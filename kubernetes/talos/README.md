# Talos

Talos Linux is a modern OS for Kubernetes. It's designed to be secure, immutable and minimal. I run a three-node Talos Linux Kubernetes cluster in my homelab.

I wanted to explore Talos for a use-case at work and I've been running it in my homelab ever since. I think it's a fantastic way to run and manage Kubernetes clusters.

Initially I ran it as described in the [old](./old) folder but when Sidero open-sourced [Omni](https://github.com/siderolabs/omni) and allowed free use for non-production I switched to that for management. A bit overkill for a single Talos cluster but it was also something I wanted to explore for work and I'm a sucker fur GUIs even though I'm a CLI guy at heart.

I run Omni in an LXC on Proxmox. I followed this [guide](https://omni.siderolabs.com/docs/how-to-guides/self-hosted/how-to-deploy-omni-on-prem/) to set it up with some minor adjustment. Below is my current command, it's on the TODO to move it to a systemd service but I haven't gotten around to it yet.

```bash
docker run -d \
  --net=host \
  --cap-add=NET_ADMIN \
  --device=/dev/net/tun \
  -v $PWD/etcd:/_out/etcd \
  -v $PWD/fullchain.pem:/tls.crt \
  -v $PWD/tls.key:/tls.key \
  -v $PWD/omni.asc:/omni.asc ghcr.io/siderolabs/omni:v0.36.0 \
  --account-id=${OMNI_ACCOUNT_UUID} \
  --name=molntuss-omni \
  --cert=/tls.crt \
  --key=/tls.key \
  --siderolink-api-cert=/tls.crt \
  --siderolink-api-key=/tls.key \
  --private-key-source=file:///omni.asc \
  --machine-api-cert=/tls.crt \
  --event-sink-port=8091 \
  --bind-addr=0.0.0.0:443 \
  --machine-api-bind-addr=0.0.0.0:8090 \
  --k8s-proxy-bind-addr=0.0.0.0:8100 \
  --advertised-api-url=https://omni.{ MY_DOMAIN }/ \
  --siderolink-api-advertised-url=https://omni.{ MY_DOMAIN }:8090/ \
  --siderolink-wireguard-advertised-addr=192.168.20.10:50180 \
  --advertised-kubernetes-proxy-url=https://omni.{ MY_DOMAIN }:8100/ \
  --auth-saml-enabled=true \
  --auth-saml-url=https://auth.{ MY_DOMAIN }/application/saml/omni/metadata/
```

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

Oh..! I also install the qemu-guest-agent and iscsi system extensions, but that was a one time choice when setting up the cluster with Omni, then it makes sure to include it in subsequent images. The "old" folder contains some docs on how to do it manually with the image factory.
