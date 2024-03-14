{{/*
Expand the name of the chart.
*/}}
{{- define "globex-account-application.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "globex-account-application.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "globex-account-application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "globex-account-application.labels" -}}
helm.sh/chart: {{ include "globex-account-application.chart" . }}
{{ include "globex-account-application.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "globex-account-application.selectorLabels" -}}
app.kubernetes.io/name: {{ include "globex-account-application.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "globex-account-application.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "globex-account-application.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
ArgoCD Syncwave
*/}}
{{- define "globex-account-application.argocd-syncwave" -}}
{{- if .Values.argocd }}
{{- if and (.Values.argocd.syncwave) (.Values.argocd.enabled) -}}
argocd.argoproj.io/sync-wave: "{{ .Values.argocd.syncwave }}"
{{- else }}
{{- "{}" }}
{{- end }}
{{- else }}
{{- "{}" }}
{{- end }}
{{- end }}