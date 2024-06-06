# [MetalLB](https://metallb.io/)

Bare metal load-balancer for Kubernetes. MetalLB assigns IP addresses to services in your from a defined IPAddressPool and advertises them on your network. This allows you to access services in your cluster from outside the cluster.

- ipaddresspool.yaml: The IP address pool to use for MetalLB. I'm just using one IP adress as everything goes through the ingress.
- l2advertise.yaml: Configures MetalLB to use layer 2 mode which is the most common mode for home networks.

In the [homelab-appset](../homelab-appset.yaml) we are enabling ignoreDifferences on some CRDs that are modified by the controller to avoid out of sync issues in ArgoCD.
