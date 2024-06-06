# Release notes for version 0.23.0

**Release date:** 2024-05-30

![AppVersion: v1.101.0](https://img.shields.io/static/v1?label=AppVersion&message=v1.101.0&color=success&logo=)
![Helm: v3](https://img.shields.io/static/v1?label=Helm&message=v3&color=informational&logo=helm)

- sync latest etcd v3.5.x rules from [upstream](https://github.com/etcd-io/etcd/blob/release-3.5/contrib/mixin/mixin.libsonnet).
- add Prometheus operator CRDs as an optional dependency. See [this PR](https://github.com/VictoriaMetrics/helm-charts/pull/1022) and [related issue](https://github.com/VictoriaMetrics/helm-charts/issues/341) for the details.

