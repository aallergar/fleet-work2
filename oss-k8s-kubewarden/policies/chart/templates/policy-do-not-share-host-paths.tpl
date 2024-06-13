{{- define "policy-do-not-share-host-paths" -}}
---
apiVersion: policies.kubewarden.io/v1
kind: ClusterAdmissionPolicy
metadata:
  name: do-not-share-host-paths-{{ include "policy-category" . }}
  annotations:
    io.kubewarden.policy.category: {{ include "policy-category" . }}
spec:
  mode: {{ include "policy-mode" . }}
  backgroundAudit: true
  module: registry.claas.com/kubewarden/policies/hostpaths-psp:v0.1.10
  mutating: false
  {{ include "privileged-namespaces-filter" . }}
  policyServer: default
  rules:
  - apiGroups:
    - ''
    apiVersions:
    - v1
    operations:
    - CREATE
    - UPDATE
    resources:
    - pods
  settings:
    allowedHostPaths:
    - pathPrefix: /tmp
      readOnly: true
{{- end -}}