# [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)

![ArgoCD overview](https://argoproj.github.io/argo-cd-ui.gif)

ArgoCD is a GitOps continuous delivery tool for Kubernetes. I use it to deploy applications to my cluster based on manifests in this git repo.

## Customizations

- [argocd-rbac-cm-patch.yaml](manifests/argocd-rbac-cm-patch.yaml):
  - Add role for users logging in via [Authentik](../Authentik)
- [argocd-cmd-params-cm-patch.yaml](manifests/argocd-cmd-params-cm-patch.yaml):
  - Run server as insecure. Terminate SSL in Ingress.
- [argocd-cm-patch.yaml](manifests/argocd-cm-patch.yaml):
  - Change url to external hostname
  - Enable kustomize to use helm
  - Dex config. OIDC is configured as described in <https://docs.goauthentik.io/integrations/services/argocd/>
- [domain-replacement-cmp.yaml](domain-replacement-cmp.yaml):
  - ArgoCD [Config Management Plugin](https://argo-cd.readthedocs.io/en/stable/operator-manual/config-management-plugins/#config-management-plugins) I use cmps to replace '{ MY_DOMAIN }' in the manifests with the actual domain. I don't know why but for some reason I'm not really confortable with having my domain in the git repo.

Another noteworthy configuration is the following block in homelab-appsey.yaml, it allows me to disable autosync and change the targetRevision of the application. This way I can test changes to the application on another branch without ArgoCD interfering.

```yaml
ignoreApplicationDifferences:
  - jsonPointers:
      - /spec/source/targetRevision
      - /spec/syncPolicy
```
