# [1Password Operator](https://github.com/1Password/onepassword-operator)

1Password Operator is a Kubernetes operator for managing Kubernetes secrets in 1Password. I store all sensitive data in 1Password and this operator allows me to sync those secrets to my Kubernetes clusters.

1Password Connect can also be used with the [External Secrets Operator](https://github.com/external-secrets/external-secrets/) which is something I might explore later on. That would allow for a smoother transition if I ever want to switch from 1Password to something else.

Deployed from the official [helm chart](https://1password.github.io/connect-helm-charts)

## Installation

This either has to be installed manually with helm first or by creating a couple of secrets beforehand. I chose the latter.

1. Create and download 1Password credentials and a connect token:

   - Sign in to your account on 1Password.com.
   - Select Developer Tools from the sidebar.
   - Under Infrastructure Secrets Management, select Other.
   - Select Create a Connect Server.
   - Follow the onscreen instructions to create a 1Password-credentials.json file and connect token.

2. Create namespace and secret Kubernetes secrets:

   ```bash
   kubectl create ns 1password
   kubectl create secret generic op-credentials -n 1password --from-file=1password-credentials.json
   kubectl create secret generic onepassword-token -n 1password --from-literal=<token>
   ```

3. Operator can now be installed via Argo with the provided manifests. To use other secret names you have to modify the values, these are defaults
