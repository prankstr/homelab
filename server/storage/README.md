# Storage

The storage setup in my server consists of 2×2TB Samsung 990 PRO NVMe drives.

The motherboard only has one M.2 slot and its PCIe 1x, so the performance would be abysmal if using that. To use 2 drives and get the full speed out of them I run a [4-slot PCIe to M.2 adapter](https://www.glotrends-store.com/products/pa41-quad-m2-nvme-to-pcie-4x16-adapter-raid) with 4×4×4×4 bifurcation, so technically I can run 4 NVMes at full bandwidth.

The NVMe disks are passed through directly to my Talos VMs with PCIe passthrough rather than VirtIO. This removes any virtualization overhead and gives near native performance.

---

## Enabling IOMMU

To get PCIe passthrough working IOMMU needs to be enabled in the BIOS.
On the Gigabyte MC12-LE0 the setting is under:

```
Advanced > AMD CBS > NBIO Common Options > IOMMU
```

---

## Loading Required Kernel Modules

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

---

## Verifying IOMMU

Once it’s back up verify that IOMMU is active:

```bash
dmesg | grep -e DMAR -e IOMMU -e AMD-Vi
```

If you see lines mentioning IOMMU or AMD-Vi you’re good to go.

---

## Identifying the NVMe Devices

List all PCI devices:

```bash
lspci
```

You should see entries like this:

```
07:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
08:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller S4LV008[Pascal]
```

---

## Checking IOMMU Groups

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

---

## Passing Through in Proxmox

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

---

