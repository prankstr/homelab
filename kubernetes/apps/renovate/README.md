# Renovate

Renovate automates the update of services and dependencies. I'm not an advanced user and I'm currently just using it for this repository with a very simple [config](./renovate.json).

It's looking for `kustomization.yaml` files in this repository and looks for updates to resources, images and helm charts. If it finds any it will create a PR with the changes.

It runs as a cronjob in Kubernetes, scheduled every hour. Deployed with self-composed manifests based on the official docs.
