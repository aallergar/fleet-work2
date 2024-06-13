{{- define "policy-no-privileged-pod" -}}
---
apiVersion: policies.kubewarden.io/v1
kind: ClusterAdmissionPolicy
metadata:
  name: no-privileged-pod-{{ include "policy-category" . }}
  annotations:
    io.kubewarden.policy.category: {{ include "policy-category" . }}
spec:
  mode: {{ include "policy-mode" . }}
  backgroundAudit: true
  module: registry.claas.com/kubewarden/policies/pod-privileged:v0.3.2
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
    resources:
    - pods
  - apiGroups:
    - ''
    apiVersions:
    - v1
    operations:
    - CREATE
    - UPDATE
    resources:
    - replicationcontrollers
  - apiGroups:
    - apps
    apiVersions:
    - v1
    operations:
    - CREATE
    - UPDATE
    resources:
    - deployments
    - replicasets
    - statefulsets
    - daemonsets
  - apiGroups:
    - batch
    apiVersions:
    - v1
    operations:
    - CREATE
    - UPDATE
    resources:
    - jobs
    - cronjobs
  settings: {}
{{- end -}}
