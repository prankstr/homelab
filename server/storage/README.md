# Storage

The storage setup in my server consists of 2×2TB Samsung 990 PRO NVMe drives.

The motherboard only has one M.2 slot and its PCIe 1x, so the performance would be abysmal if using that. To use 2 drives and get the full speed out of them I run a [4-slot PCIe to M.2 adapter](https://www.glotrends-store.com/products/pa41-quad-m2-nvme-to-pcie-4x16-adapter-raid) with 4×4×4×4 bifurcation, so technically I can run 4 NVMes at full bandwidth.

The NVMe disks are passed through directly to my Talos VMs with PCIe passthrough rather than VirtIO. This removes any virtualization overhead and gives near native performance.

In Kubernetes I use the Piraeus operator to provide storage to my clusters. I compared Longhorn, OpenEBS Mayastor, and Piraeus and ended up with the latter because of its performance to resource usage ratio. You can read how I tested them below.


## Proxmox setup

The following are the steps I’ve taken in Proxmox to set up my storage.

### Enabling IOMMU

To get PCIe passthrough working IOMMU needs to be enabled in the BIOS.  
On the Gigabyte MC12-LE0 the setting is under:

```
Advanced > AMD CBS > NBIO Common Options > IOMMU
```


### Loading Required Kernel Modules

Proxmox doesn’t load the VFIO modules by default so we need to do it manually.

Create a file at `/etc/modules-load.d/pcie-passthrough.conf` and add:

```bash
vfio
vfio_iommu_type1
vfio_pci
```

Then rebuild the initramfs:

```bash
update-initramfs -u -k all
```

After that, reboot the node.


### Verifying IOMMU

Once it’s back up verify that IOMMU is active:

```bash
dmesg | grep -e DMAR -e IOMMU -e AMD-Vi
```

If you see lines mentioning IOMMU or AMD-Vi you’re good to go.


### Identifying the NVMe Devices

List all PCI devices:

```bash
lspci
```

You should see entries like this:

```
07:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
08:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
```


### Checking IOMMU Groups

We need to make sure the NVMe drives are in separate IOMMU groups otherwise passthrough won’t work correctly.  
You can check this with:

```bash
pvesh get /nodes/<your-node-name>/hardware/pci --pci-class-blacklist ""
```

Example output:

```
│ class    │ device │ id           │ iommugroup │ vendor │ device_name                                             │
│ 0x010802 │ 0xa80c │ 0000:07:00.0 │         17 │ 0x144d │ NVMe SSD Controller S4LV008[Pascal]                     │
│ 0x010802 │ 0xa80c │ 0000:08:00.0 │         18 │ 0x144d │ NVMe SSD Controller S4LV008[Pascal]                     │
```


### Passing Through in Proxmox

Now we can pass through the drives using the Proxmox UI:

```
VM > Hardware > Add > PCI Device > Select the ID
```

After attaching them confirm that Proxmox is using the VFIO driver:

```bash
lspci -nnk -s 07:00.0
```

You should see:

```
Kernel driver in use: vfio-pci
```


## Kubernetes

To provide storage to my apps in Kubernetes I use the Piraeus operator which manages a LINSTOR storage cluster inside Kubernetes and exposes volumes through CSI.
I’m not that good with storage but after running a not-so-scientific test I ended up using LVM thin as it gave the best performance with very reasonable resource usage from what I could tell.

The test was simple:
1. Deploy each storage provider with pretty basic/default settings.
2. Create a 100 GB PVC.
3. Run a [fio](https://github.com/axboe/fio) pod that mounts the PVC and execute:

```bash
kubectl exec -it fio -- fio --name=benchtest --size=800m --filename=/volume/test --direct=1 --rw=randrw --ioengine=libaio --bs=4k --iodepth=16 --numjobs=8 --time_based --runtime=300
```

Here’s a summary of the results from my environment:

| **Metric** | **LINSTOR (LVM-thin)** | **OpenEBS (Mayastor)** | **LINSTOR (ZFS)** | **Longhorn (v2 engine)** |
|:--|:--:|:--:|:--:|:--:|
| **Read Bandwidth (MiB/s)** | 148 | 143 | 93 | 83 |
| **Write Bandwidth (MiB/s)** | 148 | 143 | 93 | 83 |
| **Total Bandwidth (MiB/s)** | 296 | 286 | 186 | 166 |
| **Read IOPS** | ≈37,000 | 36,000 | 23,000 | 21,000 |
| **Write IOPS** | ≈37,000 | 36,000 | 23,000 | 21,000 |
| **Total IOPS** | ≈75–87k | 72k | 47k | 42k |
| **Average Read Latency (ms)** | 0.32 | 1.5 | 0.8 | 2.1 |
| **Average Write Latency (ms)** | 3.0 | 1.5 | 1.0 | 3.8 |
| **99.9th Percentile Latency (ms)** | 15–25 | 8–10 | ~60 | 15–20 |

---

In all tests the disks were clean and provided to the storage engine as a raw block device. As you can see Piraeus with LVM thin and Mayastor were very close in terms of throughput and latency but Piraeus did it while consuming very little CPU and RAM.

Worty mentions are LINSTOR with LVM thick which had even better performance but it doesn’t have snapshot support in LINSTOR and that’s not something I’m willing to compromise on. Ceph was never evaluated because it would simply be too heavy for my environment.
