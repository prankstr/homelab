# [external-dns](https://kubernetes-sigs.github.io/external-dns/v0.14.2/)

ExternalDNS manages DNS records for services exposed with ingresses. It uses the DNS provider's API to manage records, like cert-manager it supports a lot of DNS providers out of the box but can be extended with webhooks for unsupported providers.

I use AdGuard Home for DNS and it's not supported by external-dns so I use the [external-dns-provider-adguard](https://github.com/muhlba91/external-dns-provider-adguard) provided by Muhlba91.

It's configured to look for my domain in ingresses with the configuration below. If it finds an ingress with my domain it will create a DNS record for it in AdGuard Home.

```yaml
args:
  - --source=ingress
  - --domain-filter={ MY_DOMAIN }
```
