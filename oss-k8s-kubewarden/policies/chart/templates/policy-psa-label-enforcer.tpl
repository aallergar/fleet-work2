{{- define "policy-psa-label-enforcer" -}}
---
apiVersion: policies.kubewarden.io/v1
kind: ClusterAdmissionPolicy
metadata:
  {{- if .privileged }}
  name: psa-label-enforcer-privileged
  {{- else }}
  name: psa-label-enforcer-unprivileged
  {{- end }}
spec:
  mode: protect
  module: registry.claas.com/kubewarden/policies/psa-label-enforcer:v0.1.2
  mutating: true
  namespaceSelector:
    matchExpressions:
    - key: "kubernetes.io/metadata.name"
      {{- if .privileged }}
      operator: In
      {{- else }}
      operator: NotIn
      {{- end }}
      values: [{{ join ", " .privilegedNamespaces }}]
  policyServer: default
  rules:
  - apiGroups:
    - ''
    apiVersions:
    - v1
    resources:
    - namespaces
    operations:
    - CREATE
    - UPDATE
  settings:
    description: null
    modes:
      {{- if .privileged }}
      enforce: privileged
      {{- else }}
      enforce: baseline
      {{- end }}
      enforce-version: latest
      audit: baseline
      audit-version: latest
      warn: baseline
      warn-version: latest
    ignoreRancherNamespaces: false
{{- end -}}
