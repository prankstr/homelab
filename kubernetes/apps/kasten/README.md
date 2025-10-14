# [K10](https://docs.kasten.io/latest/)

Kasten K10 is a backup tool for Kubernetes similar to Velero. The main reason for choosing K10 over anything else was mostly for work but it's a nice tool so I haven't bothered changing it.

Deployed from official [helm chart](https://charts.kasten.io), see [values.yaml](./values.yaml) for config.

I’m backing up to Backblaze(S3-compatible storage) and I only backup apps with persistent volumes + ArgoCD and all CRDs. Since everything is managed with GitOps I dont have to worry much about backing up the stateless stuff but backing up ArgoCD and the CRDs helps me get back on track if something happens. The persistent volume backups cover the actual data I have.

Noteworthy files:

- **dashboard.json**: Provision the K10 dashboard in Grafana.
- **vmpodscrape.yaml**: Scrape job for K10 pods needed for the dashboard
- **vmscrapeconfig.yaml**: Http discovery scrape config for K10 pods needed for the dashboard
- **oidc-secret.yaml**: OIDC secret to configure K10 towards Authentik.
- **rbac-path:yaml:** Updates a cluster role binding with permission for Authentik to authenticate users.
- **policies-and-profiles/\***: Location profiles, preset and policies for Backups.

![k10 overview](/assets/images/k10-overview.png)
