{{- define "tekton.labels" -}}
app.kubernetes.io/instance: default
app.kubernetes.io/part-of: tekton-pipelines
helm-release: {{ .Release.Name | quote }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version}}"
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}