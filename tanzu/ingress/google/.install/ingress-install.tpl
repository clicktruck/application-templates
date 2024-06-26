apiVersion: kappctrl.k14s.io/v1alpha1
kind: App
metadata:
  name: tanzu-ingress
  namespace: tanzu-user-managed-packages
  annotations:
    kapp.k14s.io/change-group: tanzu-ingress/app
    kapp.k14s.io/change-rule: "upsert after upserting tanzu-ingress/rbac"
spec:
  serviceAccountName: ingress-sa
  fetch:
  - git:
      url: https://github.com/clicktruck/application-templates
      ref: origin/{{ .git_ref_name }}
      secretRef:
        name: git-https-for-carvel
  template:
  - ytt:
      paths:
      - tanzu/ingress/google/base

      valuesFrom:
      - configMapRef:
          name: tanzu-ingress
      - secretRef:
          name: tanzu-ingress
  deploy:
  - kapp: {}
