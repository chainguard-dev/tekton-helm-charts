{{- define "tekton_pipelines.labels" -}}
app.kubernetes.io/instance: default
app.kubernetes.io/part-of: tekton-pipelines
helm-release: {{ .Release.Name | quote }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version}}"
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{- define "tekton_pipelines.labelselector" -}}
app.kubernetes.io/instance: default
app.kubernetes.io/part-of: tekton-pipelines
{{- end }}


{{/*
Create the image path for the passed in image field
*/}}
{{- define "pipeline_deployment.image" -}}
{{- printf "%s:%s@%s" .repository .tag .version -}}
{{- end -}}

{{- define "pipelines_webhook.image" -}}
{{- printf "%s:%s@%s" .repository .tag .version -}}
{{- end -}}

{{- define "pipeline_deployment.argsImages" -}}
{{- $list := list -}}
{{- range $k, $v := .Values.pipeline_deployment.args -}}
{{- $list = append $list (printf "\"-%s\",\"%s\"" $v.name $v.image) -}}
{{- end -}}
{{ join ", " $list }}
{{- end -}}