apiVersion: kappctrl.k14s.io/v1alpha1
kind: App
metadata:
  name: {{ .app_name }}-additional
  namespace: tap-install-gitops
spec:
  serviceAccountName: tap-install-gitops-sa
  syncPeriod: 1m
  fetch:
  - git:
      url: https://github.com/clicktruck/application-templates
      ref: origin/{{ .git_ref_name }}
      secretRef:
        name: git-https-for-carvel
  template:
  - ytt:
      paths:
      - tanzu/application-platform/profiles/additional/{{ .profile }}

      valuesFrom:
      - configMapRef:
          name: {{ .app_name }}
      - secretRef:
          name: {{ .app_name }}
  deploy:
  - kapp: {}
