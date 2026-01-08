# [kgateway](https://kgateway.dev/)

Gateway API implementation for Kubernetes. Used to expose services in the cluster to the outside world using Gateway, HTTPRoute and other Gateway API resources.

Deployed from the official helm chart.

Currently only kromgo is exposed via kgateway. Full migration from ingress-nginx is pending the release of [ListenerSets](https://cert-manager.io/announcements/2025/11/26/ingress-nginx-eol-and-gateway-api/).
