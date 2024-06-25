# [Headscale](https://github.com/juanfont/headscale)

Headscale is a self-hosted open source implementation of the Tailscale control server. It's built on Wireguard but adds a lot of features as well as ease of management.

I use it to connect to my LAN from anywhere and access my services that way rather than exposing over the internet.

Deployed with self-composed manifests based on [this](https://github.com/juanfont/headscale/blob/main/docs/running-headscale-container.md) together with [headscale-admin](https://github.com/GoodiesHQ/headscale-admin) which is a web UI for managing headscale. Currently exposed with a `NodePort` service and routed to via HAProxy running on OPNsense. This is to keep it separate from the rest of the services in the cluster.

![headscale-admin overview](/assets/images/headscale-admin-overview.png)
