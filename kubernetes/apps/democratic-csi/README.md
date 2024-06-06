# [democratic-csi](https://github.com/democratic-csi/democratic-csi)

CSI provider with TrueNAS support. I use it to automatically provision storage for services running in kubernetes. iSCSI is used for RWO volumes and NFS for RWX volumes if needed.

Democratic-csi is deployed from the official [helm chart](https://democratic-csi.github.io/charts/), see [values](./manifests/values.yaml) for config. Yes, there is an API key in the values file but it's no exposed to the internet. I'm not too worried about it :)

I have storageClasses for both iSCSI and NFS. The iSCSI storageClass is default and NFS is only used if RWX volumes are needed. Both iSCSI and NFS are also available with encrypted volumes meaning the data is stored on a ZFS dataset with encryption enabled.

The configuration is a bit of a mess but once it's up and running it's pretty stable.
