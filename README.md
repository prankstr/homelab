# Homelab

![Every homelab](/assets/images/homelab.gif)

Welcome to my homelab!

This repo acts as my personal homelab knowledge base and source for GitOps deployments but I decided to make it public in case someone finds it useful or interesting.

## 🛠️ Hardware

The core of my homelab is a single server but it's sufficiently beefy to run everything I need. Specs:

- **Motherboard:** Gigabyte MC12-LE0. Cheap server motherboard with IPMI that uses regular Ryzen CPUs.
- **CPU:** AMD Ryzen 3700X.
- **RAM:** 64GB of ECC memory.
- **Boot Storage/Proxmox storage:** ZFS mirror with 2x500GB NVME drives.
- **Data Storage:** ZFS RAIDZ1 array with 3 WD RED 3TB drives.

## 🥡 Software and Applications

Since I have just the one server I virtualize everything from my router and other infrastructure applications to Kubernetes.

- **Proxmox VE:** Debian and KVM based hypervisor. Everything runs on top of this.
- **OPNsense(VM):** FreeBSD based firewall and router. No, virtualizing your router/firewall isn't optimal but it's a calculated risk.
- **UniFi Network Application(LXC):** Used to manage my UniFi devices.
- **AdGuard Home(LXC):** Network-wide ad blocking, integrated with external-dns in Kubernetes.
- **TrueNAS SCALE(VM):** NAS software with the WD Reds passed through, used for storage to k8s cluster via democratic-csi and as traditional NAS storage on rare occassions.
- **Home Assistant OS(VM):** Home automation engine.
- **Omni(LXC)**: Management tool for Talos Linux
- **Talos Linux Kubernetes Cluster(VMs):** A three-node Talos Linux kubernetes cluster.

### 🚀 Kubernetes

I work with Kubernetes for a living so while some stuff might be overkill it helps me stay somewhat up to date with the tech.

Here is an overview of the services I run, some of them have more detailed explanations and configuration notes in their respective folder in the [kubernetes/apps](./kubernetes/apps) folder.

#### Infrstructure(i.e stuff that enables me to deploy and manage other stuff)

- **1Password Connect/Operator:** Sync secrets from 1Password to Kubernetes.
- **ArgoCD:** Facilitates GitOps. Automating the deployment of applications based on manifests in this git repo.
- **cert-manager:** Automatically provisions and renews certificates.
- **democratic-csi:** CSI provisioner that works with TrueNAS. Provisions persistent volumes backed by TrueNAS.
- **ExternalDNS:** Integrated with AdGuard Home and automatically configures DNS records from Kubernetes.
- **Grafana:** Visualization tool. Used to visualize metrics from the cluster and other sources.
- **Ingress-Nginx:** Ingress controller. A reverse proxy for services in the cluster.
- **Kasten K10:** Backup solution for Kubernetes applications. Since I deploy with GitOps this is mainly used for backing up data.
- **MetalLB:** Load balancer for bare metal Kubernetes clusters.
- **VictoriaMetrics:** Metric monitoring system. Drop-in replacement for Prometheus.
- **VictoriaLogs:** Logs monitoring system. Similar to Loki/Ealsticsearch.

#### Actual applications

- **Authentik:** Self-hosted IDP(Identity provider). Borderline infra app but I mainly set it up for fun.
- **Headscale:** Self-hosted Tailscale control server.
- **Mealie:** Self-hosted recepie manager.
- **Morphos:** Self-hosted file converter.
- **Vikunja:** Self-hosted todo app.

The ratio is a bit skewed but the infra stuff is where the learning is at 😎
