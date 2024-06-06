# [VictoriaMetrics](https://github.com/VictoriaMetrics/VictoriaMetrics)

VictoriaMetrics is a drop-in replacement for Prometheus. I find it to be much more resource-efficient and easier to manage than Prometheus.

I use the official charts found [here](https://github.com/VictoriaMetrics/helm-charts) to deploy it.

- **values.yaml:** Values for the victoria-metrics-k8s-stack chart.
- **datasource.yaml:** Provisions VictoriaMetrics as a datasource in Grafana.
- **vmagent-patch.yaml**: Enable servier side apply on the vmagent ConfigMap to avoid issues with metadata being to long.
- **coredns-patch.yaml:** Set namespace to kube-system for the coredns service since that's where to pods are located.
- **values-logs.yaml:** Values for the victoria-logs chart.
- **values-external.yaml:** Values for a separate installation of the vmagent component. This is used for scraping external targets and avoid getting k8s related labels applied to the metrics.
- **static-scrapes.yaml:** Static scrape targets for the external vmagent.

## [VictoriaLogs](https://docs.victoriametrics.com/victorialogs/)

VictoriaMetrics also features a log component similar to Loki or Elasticsearch.

In professional contexts I've only encountered Loki and Elastic so far but for homelab purposes I rarely need to look at logs in the database rather than just quickly checking the pod when troubleshooting.

Loki and Elastic are, in my opinion, hazzles to setup and maintain while VictoriaLogs is very easy to setup for my needs as you can see from the minimal configuration.

There is no official datasource in Grafana for VictoriaLogs but they provide one of their [own](https://docs.victoriametrics.com/victorialogs/grafana_datasource/) that you can install if you want the logs in Grafana.

There is a UI bundled with VictoriaLogs, that's good enough for me since I use it rarely.
![VictoriaLogs overview](/assets/images/victoria-logs-overview.png)
