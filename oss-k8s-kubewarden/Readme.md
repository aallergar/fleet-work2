# Kubewarden

## HELM Charts

Get HELM charts from public repo and push them to our registry (OCI currently not supported by fleet with authentication and self signed certificate, thus you have to upload the tgz files via UI). Also see [installtion documentation](https://docs.kubewarden.io/quick-start#installation).

```bash
helm repo add kubewarden https://charts.kubewarden.io
helm repo update kubewarden
helm pull kubewarden/kubewarden-crds
helm pull kubewarden/kubewarden-controller
helm pull kubewarden/kubewarden-defaults
```
