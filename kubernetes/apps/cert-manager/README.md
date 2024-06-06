# [cert-manager](https://cert-manager.io/docs/)

cert-manager automatically provisions and renews certificates. I use it with Lets Encrypt as the issuer and Simply.com as the DNS provider for the DNS01 challenge. Simply isn't officially supported by cert-manager but you can use webhooks to make it work. I use the [simply-dns-webhook](https://github.com/RunnerM/simply-dns-webhook) from RunnerM.

To automatically provision certificates for ingresses you need to add annotations to the ingress like this:

```yaml
annotations:
  cert-manager.io/cluster-issuer: "letsencrypt"
```

And add the tls section like this:

```yaml
tls:
  - hosts:
      - example.com
    secretName: example-com-cert
```
