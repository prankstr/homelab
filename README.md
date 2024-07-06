<div align="center">

# Homelab

![Homelab-gif](/assets/images/homelab.gif)

</div>

<div align="center">
<br/>

[![Talos](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dtalos_version&style=for-the-badge&logo=talos&logoColor=white&color=blue&label=%20)](https://www.talos.dev/)&nbsp;&nbsp;
[![Kubernetes](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dkubernetes_version&style=for-the-badge&logo=kubernetes&logoColor=white&color=blue&label=%20)](https://www.talos.dev/)&nbsp;&nbsp;
![Renovate](https://img.shields.io/github/actions/workflow/status/prankstr/homelab/renovate.yaml?branch=main&label=&logo=renovate&style=for-the-badge&color=blue)

</div>

<div align="center">

[![Age-Days](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_age_days&style=flat-square&label=Age)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Uptime-Days](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_uptime_days&style=flat-square&label=Uptime)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Node-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_node_count&style=flat-square&label=Nodes)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Pod-Count](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_pod_count&style=flat-square&label=Pods)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![CPU-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_cpu_usage&style=flat-square&label=CPU)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Memory-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_memory_usage&style=flat-square&label=Memory)](https://github.com/kashalls/kromgo/)&nbsp;&nbsp;
[![Power-Usage](https://img.shields.io/endpoint?url=https%3A%2F%2Fkromgo.p6r.dev%2Fquery%3Fformat%3Dendpoint%26metric%3Dcluster_power_usage&style=flat-square&label=Power)](https://github.com/kashalls/kromgo/)

</div>

## 📖 Overview

Kubernetes Homelab built on Talos Linux, managed with GitOps using ArgoCD and Renovate.

This repo is the source for my GitOps deployments as well as my personal knowledge bank with notes for my homelab. I decided to make it public in case someone finds it useful or interesting.

Currently most of the content is regarding my Kubernetes cluster and the applications I run on it. I'm looking to expand it with more general homelab stuff as well as time goes on.

## 🛠️ Hardware

The core of my homelab is a single server but it's sufficiently beefy to run everything I need. Specs:

- **Motherboard:** Gigabyte MC12-LE0. Cheap server motherboard with IPMI that uses regular Ryzen CPUs.
- **CPU:** AMD Ryzen 3700X.
- **RAM:** 64GB of ECC memory.
- **Boot Storage/Proxmox storage:** ZFS mirror with 2x500GB NVME drives.
- **Data Storage:** ZFS RAIDZ1 array with 3 WD RED 3TB drives.

## 🥡 Software and Applications

Since I have just the one server I virtualize everything from my router and other infrastructure applications to Kubernetes.

- [Proxmox VE](https://www.proxmox.com/)(BM): Debian and KVM based hypervisor. Everything runs on top of this.
- [OPNsense](https://opnsense.org/)(VM): FreeBSD based firewall and router. No, virtualizing your router/firewall isn't optimal but it's a calculated risk.
- [UniFi Network Server](https://help.ui.com/hc/en-us/articles/360012282453-Self-Hosting-a-UniFi-Network-Server)(LXC): Used to manage my UniFi devices.
- [AdGuard Home](https://github.com/AdguardTeam/AdGuardHome)(LXC): Network-wide ad blocking, integrated with external-dns in Kubernetes.
- [TrueNAS SCALE](https://www.truenas.com/truenas-scale/)(VM): NAS software with the WD Reds passed through, used for storage to k8s cluster via democratic-csi and as traditional NAS storage on rare occassions.
- [Home Assistant](https://github.com/home-assistant/core)(VM): Home automation engine.
- [Omni](https://github.com/siderolabs/omni)(LXC): Management tool for Talos Linux
- [Talos Linux Kubernetes Cluster](https://github.com/siderolabs/talos)(VMs): A three-node Talos Linux kubernetes cluster.

### 🚀 Kubernetes

I work with Kubernetes for a living so while some stuff might be overkill it helps me stay somewhat up to date with the tech which is essentially the goal of the homelab.

Here is an overview of the services I run, some of them have more detailed explanations and configuration notes in their respective folder in the [kubernetes/apps](./kubernetes/apps) folder.

#### Platform services

_(i.e stuff that enables me to deploy and manage other stuff)_

- [1Password Connect Operator](https://github.com/1Password/onepassword-operator): Secret management. Sync secrets from 1Password to Kubernetes.
- [Argo CD](https://github.com/argoproj/argo-cd): Facilitates GitOps. Automating the deployment of applications based on manifests in this git repo.
- [cert-manager](https://github.com/cert-manager/cert-manager): Automatically provisions and renews certificates.
- [democratic-csi](https://github.com/democratic-csi/democratic-csi): CSI provisioner for TrueNAS. Provisions persistent volumes backed by TrueNAS.
- [ExternalDNS](https://github.com/kubernetes-sigs/external-dns): Integrated with AdGuard Home and automatically configures DNS records from Kubernetes.
- [Github ARC](https://github.com/actions/actions-runner-controller): Github Actions Runner Controller. Runs Github Actions runners in the cluster.
- [Grafana](https://github.com/grafana/grafana): Visualization tool. Used to visualize metrics from the cluster and other sources.
- [Ingress-Nginx](https://github.com/kubernetes/ingress-nginx): Ingress controller. A reverse proxy for services in the cluster.
- [K10](https://docs.kasten.io/latest/index.html): Backup solution for Kubernetes applications. Since I deploy with GitOps this is mainly used for backing up data.
- [MetalLB](https://github.com/metallb/metallb): Load balancer for bare metal Kubernetes clusters.
- [Renovate](https://github.com/renovatebot/renovate): Automated dependency update tool. Used to keep the manifests in this repo up to date.
- [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics): Monitoring system for metrics and logs. Drop-in replacement for Prometheus.

#### Actual applications

- [Authentik](https://github.com/goauthentik/authentik): Self-hosted IDP(Identity provider). Borderline infra app but I mainly set it up for fun.
- [Headscale](https://github.com/juanfont/headscale): Self-hosted Tailscale control server.
- [Kromgo](https://github.com/kashalls/kromgo): Sort of a reverse proxy for prometheus metrics.
- [Mealie](https://github.com/mealie-recipes/mealie): Self-hosted recepie manager.
- [Morphos](https://github.com/danvergara/morphos): Self-hosted file converter.
- [Vikunja](https://vikunja.io/): Self-hosted todo app.

The ratio is a bit skewed but the platform stuff is where the learning is at 😎
