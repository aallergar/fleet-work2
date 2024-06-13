{{- define "policy-drop-capabilities" -}}
---
apiVersion: policies.kubewarden.io/v1
kind: ClusterAdmissionPolicy
metadata:
  name: drop-capabilities-{{ include "policy-category" . }}
  annotations:
    io.kubewarden.policy.category: {{ include "policy-category" . }}
spec:
  mode: {{ include "policy-mode" . }}
  backgroundAudit: true
  module: registry.claas.com/kubewarden/policies/capabilities-psp:v0.1.15
  mutating: true
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
    required_drop_capabilities:
    - ALL
{{- end -}}
