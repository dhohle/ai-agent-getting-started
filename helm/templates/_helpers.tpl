{{/* Standard labels to apply to all resources. */}}
{{- define "template.labels" }}
  labels:
    helm.sh/chart: {{ printf "%s-%s" $.Chart.Name $.Chart.Version | replace "+" "_" | quote }}
    app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
    app.kubernetes.io/instance: {{ .Release.Name | quote }}
    date: {{ now | htmlDate }}
{{- end }}
