# [Kromgo](https://github.com/kashalls/kromgo)

[Kromgo](https://github.com/kashalls/kromgo) is sort of like a reverse proxy for prometheus metric. I use it to expose the metrics seen on the front-page README such as Talos version and node status etc. Inspired by [oneDr0ps repo](https://github.com/onedr0p/home-ops).

Deployed with self-composed manifests. Exposed with a `NodePort` service, routed to via HAProxy running on OPNsense.
