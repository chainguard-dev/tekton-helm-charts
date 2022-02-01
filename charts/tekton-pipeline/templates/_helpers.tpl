{{- define "tekton.labels" -}}
    app.kubernetes.io/instance: default
    app.kubernetes.io/part-of: tekton-pipelines
    helm-release: {{ .Release.Name }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version}}
    app.kubernetes.io/version: {{ .Chart.AppVersion }}
{{- end }}