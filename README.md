# Helm chart for Masaic Platform

helm repo add mongodb https://mongodb.github.io/helm-charts
helm install community-operator-crds mongodb/community-operator-crds
helm upgrade --install --namespace "masaic-cloud" masaic-test . --create-namespace
