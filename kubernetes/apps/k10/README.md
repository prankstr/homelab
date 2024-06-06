# [K10](https://docs.kasten.io/latest/)

Kasten K10 is a backup tool for Kubernetes similar to Velero. The main reason for choosing K10 over anything else was purely for work but it's a good tool so I haven't bothered changing it.

Deployed from official [helm chart](https://charts.kasten.io), see [values.yaml](./values.yaml) for config. The rclone stuff is currently not used. I'm currently backing up to S3.

Noteworthy files:

- **dashboard.json**: Provision the K10 dashboard in Grafana.
- **vmpodscrape.yaml**: Scrape job for K10 pods needed for the dashboard
- **vmscrapeconfig.yaml**: Http discovery scrape config for K10 pods needed for the dashboard
- **oidc-secret.yaml**: OIDC secret to configure K10 towards Authentik.
- **rbac-path:yaml:** Updates a cluster role binding with permission for Authentik to authenticate users.

![k10 overview](/assets/images/k10-overview.png)
