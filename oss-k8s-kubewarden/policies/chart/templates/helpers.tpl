{{- define "privileged-namespaces-filter" -}}
namespaceSelector:
    matchExpressions:
    - key: kubernetes.io/metadata.name
      {{- if .enforce }}
      operator: NotIn
      {{- else }}
      operator: In
      {{- end }}
      values: [{{ join ", " .privilegedNamespaces }}]
{{- end -}}

{{- define "policy-mode" -}}
{{- if .enforce }}protect
{{- else }}monitor
{{- end }}
{{- end -}}

{{- define "policy-category" -}}
{{ .name }}
{{- end -}}