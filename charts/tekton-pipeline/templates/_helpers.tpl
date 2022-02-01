{{- define "tekton.labels" -}}
app.kubernetes.io/instance: default
app.kubernetes.io/part-of: tekton-pipelines
helm-release: {{ .Release.Name | quote }}
helm.sh/chart: "{{ .Chart.Name }}-{{ .Chart.Version}}"
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}

{{- define "tekton.labelselector" -}}
app.kubernetes.io/instance: default
app.kubernetes.io/part-of: tekton-pipelines
{{- end }}


{{/*
Create the image path for the passed in image field
*/}}
{{- define "deployment.image" -}}
{{- printf "%s:%s@%s" .repository .tag .version -}}
{{- end -}}

{{- define "webhook.image" -}}
{{- printf "%s:%s@%s" .repository .tag .version -}}
{{- end -}}

{{- define "deployment.argsImages" -}}
{{- $list := list -}}
{{- range $k, $v := .Values.deployment.args -}}
{{- $list = append $list (printf "\"-%s\",\"%s\"" $v.name $v.image) -}}
{{- end -}}
{{ join ", " $list }}
{{- end -}}