# Talos

Talos Linux is a modern OS for Kubernetes. It's designed to be secure, immutable and minimal. I run a three-node Talos Linux Kubernetes cluster in my homelab.

I wanted to explore Talos for a use-case at work and I've been running it in my homelab ever since. I think it's a fantastic way to run and manage Kubernetes clusters.

Initially I ran it as described in the [old](./old) folder but when Sidero open-sourced [Omni](https://github.com/siderolabs/omni) and allowed free use for non-production I switched to that for management. A bit overkill for a single Talos cluster but it was also something I wanted to explore for work and I'm a sucker fur GUIs even though I'm a CLI guy at heart.

## Omni

I run Omni in an LXC on Proxmox. I followed this [guide](https://omni.siderolabs.com/docs/how-to-guides/self-hosted/how-to-deploy-omni-on-prem/) to set it up with some minor adjustment.

Auto updates of [Omni](https://github.com/siderolabs/omni) is enabled by having renovate watch the [docker-compose.yaml](./docker-compose.yaml) file and on the host where [Omni](https://github.com/siderolabs/omni) runs I have a [script](./updater.sh) that checks for updates to the compose file and restarts the container if there is a new version.

![omni-overview](/assets/images/omni-overview.png)

## Configuration

As for the cluster I don't do a whole lot of configuration, Omni takes care of alot but since I just run 3 nodes I allow scheduling on the control plane. Other than that I just change the machine host name.

```yaml
cluster:
  allowSchedulingOnControlPlanes: true
```

```yaml
machine:
  network:
    hostname: "talos-1"
```

I also install the qemu-guest-agent and iscsi system extensions, but that was a one time choice when setting up the cluster with Omni, then it makes sure to include it in subsequent images. The "old" folder contains some docs on how to do it manually with the image factory.
