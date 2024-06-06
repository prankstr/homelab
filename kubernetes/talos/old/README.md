# Talos

## Prerequisites

Before starting, ensure you have `talosctl` installed. If not, install it with `curl -sL https://talos.dev/install | sh`

## Files

### boot-assets.yaml

This contains the configuration for the image to generate from the [Talos Image Factory](https://factory.talos.dev/). I add `qemu-guest-agent` for integration with Proxmox and `iscsi-tools` for iscsi support with democratic-csi. [Official docs](https://www.talos.dev/v1.6/talos-guides/install/boot-assets/).

### talos[n].patch

Machine individual configuration. The only unique thing is really the hostname but I prefer to keep anything that's not in the boilerplate config in the patch files.

## Creating a cluster

I followed the [official docs](https://www.talos.dev/v1.6/talos-guides/install/virtualized-platforms/proxmox/) for Proxmox but handle configuration according to the [Generate and apply config](#generate-and-apply-config) section of this document

## Upgrading a cluster

### OS upgrade

Generate a new image, the latest version is used by default:

```shell
curl -X POST --data-binary @boot-assets.yaml https://factory.talos.dev/schematics
{"id":"b8e8fbbe1b520989e6c52c8dc8303070cb42095997e76e812fa8892393e1d176"}
```

Upgrade nodes with new image:

```bash
talosctl upgrade --nodes <node-ip> --image ghcr.io/siderolabs/installer:v1.6.4
```

Done!

### K8s upgrade

Just run this command:

```bash
talosctl --nodes <controlplane node> upgrade-k8s --to <version>
```

Note that the --nodes parameter specifies the control plane node to send the API call to, but all members of the cluster will be upgraded.

## Generate and apply config

1: If working with an existing cluster, get secrets.yaml from it's secure location or from the cluster directly if you have access:

```bash
talosctl gen secrets --from-controlplane-config controlplane.yaml -o secrets.yaml
```

2: Generate boilerplate machine configuration, run with `--with-secrets secrets.yaml` if it's a new cluster and you didn't do step 1:

```bash
talosctl gen config --with-secrets secrets.yaml my-cluster https://k8s.domain.tld:6443
```

3: Generate image with extensions and update the patch files with the returned id:

```shell
curl -X POST --data-binary @boot-assets.yaml https://factory.talos.dev/schematics
{"id":"b8e8fbbe1b520989e6c52c8dc8303070cb42095997e76e812fa8892393e1d176"}
```

4: Generate machine specific configuration for each node:

```bash
talosctl machineconfig patch controlplane.yaml --patch @talos0.patch --output talos0.yaml
talosctl machineconfig patch controlplane.yaml --patch @talos1.patch --output talos1.yaml
talosctl machineconfig patch controlplane.yaml --patch @talos2.patch --output talos2.yaml
```

5: Apply the configuration to each machine(add --insecure if node is in maintenance):

```bash
talosctl apply-config --file talos0.yaml --nodes <Ip-of-talos0>
talosctl apply-config --file talos1.yaml --nodes <Ip-of-talos1>
talosctl apply-config --file talos2.yaml --nodes <Ip-of-talos2>
```

6: Upgrade Talos if needed:

```shell
talosctl upgrade -n  <node-ip>
```
