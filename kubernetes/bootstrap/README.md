# Bootstrap

I'm bootstraping the cluster by adding bootstrap-argocd.yaml to Talos as an extraManifest. This file is rebuilt whenever there is a PR to main that includes changes to any of the ArgoCD manifests.

```yaml
cluster:
  extraManifests:
    - url: https://raw.githubusercontent.com/prankstr/homelab/main/kubernetes/bootstrap/bootstrap-argocd.yaml
```

This installs ArgoCD with an application[(argocd-app.yaml)](argocd/argocd-app.yaml) to manage ArgoCD itself and an applicationset[(homelab-appset)](argocd/homelab-appset.yaml) that generates an app for each folder under [kubernetes/apps](../apps) to bootstrap the rest of the cluster. Some things will intially fail to apply because some CRDs will be missing but it should sort itself out.

To complete the bootstrap, secrets for 1Password has to be created manually. See [1Password](../apps/1password/README.md) for more information.

I'm yet to fully test this process but it should work.. in theory.. :)
