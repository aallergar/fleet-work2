{{- define "policy-do-not-run-as-root" -}}
---
apiVersion: policies.kubewarden.io/v1
kind: ClusterAdmissionPolicy
metadata:
  name: do-not-run-as-root-{{ include "policy-category" . }}
  annotations:
    io.kubewarden.policy.category: {{ include "policy-category" . }}
spec:
  mode: {{ include "policy-mode" . }}
  backgroundAudit: true
  module: registry.claas.com/kubewarden/policies/user-group-psp:v0.5.0
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
    run_as_group:
      rule: RunAsAny
    run_as_user:
      rule: MustRunAsNonRoot
    supplemental_groups:
      rule: RunAsAny
{{- end -}}
