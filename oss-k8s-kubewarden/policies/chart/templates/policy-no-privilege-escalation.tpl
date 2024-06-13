{{- define "policy-no-privilege-escalation" -}}
---
apiVersion: policies.kubewarden.io/v1
kind: ClusterAdmissionPolicy
metadata:
  name: no-privilege-escalation-{{ include "policy-category" . }}
  annotations:
    io.kubewarden.policy.category: {{ include "policy-category" . }}
spec:
  mode: {{ include "policy-mode" . }}
  backgroundAudit: true
  module: registry.claas.com/kubewarden/policies/allow-privilege-escalation-psp:v0.2.6
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
  settings:
    default_allow_privilege_escalation: false
{{- end -}}
