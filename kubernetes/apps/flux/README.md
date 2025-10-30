# Flux

Flux is a GitOps-based continuous delivery tool for Kubernetes. I use it to deploy applications to my cluster based on manifests stored in this Git repository.

I've been running ArgoCD for years, both in my homelab and at work. While I wouldn’t claim to have fully mastered ArgoCD I definitely know my way around it. Flux on the other hand is completely new territory for me so I decided to migrate from ArgoCD to Flux in my homelab to get familiar with it and hopefully pick up a few new skills along the way.

The last version of my repository that used ArgoCD can be found [here](https://github.com/prankstr/homelab/releases/tag/argocd)

### Structure and Deployment Flow

All Kubernetes manifests are placed under `kubernetes/apps/` and each application lives in its own directory named after the namespace it will be deployed to.

Each application directory typically contains:

- A `kustomization.yaml` that serves as the base entry point.
- A `namespace.yaml` defining the namespace for the app.
- A `flux-kustomization.yaml` defining the Flux `Kustomization` resource that applies the app manifests.
- An `app/` subdirectory containing the actual Kubernetes manifests.

Flux is bootstrapped to `kubernetes/apps/`, and from there it automatically discovers each top-level `kustomization.yaml` within the application directories.

Each of these base Kustomizations is responsible for:

1. Creating the target namespace.
2. Applying the corresponding Flux `Kustomization` resource defined in `flux-kustomization.yaml`.

The Flux Kustomization then deploys the application itself using either **HelmReleases** or plain **Kustomize** depending on the app.
