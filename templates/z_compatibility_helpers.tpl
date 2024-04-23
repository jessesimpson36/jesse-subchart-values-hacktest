{{- if .Values.identity.keycloak -}}
    {{- $_ := set .Values "keycloak" (deepCopy .Values.identity.keycloak | mergeOverwrite .Values.keycloak) -}}
{{- end -}}
