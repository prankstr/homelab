# [Grafana](https://grafana.com/)

Don't think this needs an introduction, it's a monitoring tool that can be used to visualize data from a lot of different sources. I use it to visualize metrics from my kubernetes cluster and other things in the homelab and around the house.

Deployed from the official [helm chart](https://grafana.github.io/helm-charts) with some extra datasources and dashboards, see [values](./manifests/values.yaml) for config.

Noteworthy files:

- **dashboards/\*:** Dashboards for Grafana.
- **tibber-datasource.yaml:** Provisions the Infinity datasource in Grafana that I use to fetch data from Tibber.
- **tibber-secret.yaml** Secret with credentials for the Tibber API.

I don't use any persistent storage for Grafana, everything is provisioned via manifests. Additional dashboards and datasources are deployed from the apps that provide and/or use them so I don't have to manage dependencies in multiple places.

![Grafana overview](/assets/images/grafana-overview.png)
