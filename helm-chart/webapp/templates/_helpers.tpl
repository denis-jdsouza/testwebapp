{{/* vim: set filetype=mustache: */}}
{{/*
Create env list.
*/}}
{{- define "makeServiceNamespace" -}}
{{- printf "%s-%s" .Values.appName .Values.environment -}}
{{- end -}}