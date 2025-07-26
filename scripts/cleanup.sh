#!/bin/bash

set -e

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <namespace> <release>" >&2
  echo "Error: Both <namespace> and <release> arguments are required." >&2
  exit 1
fi

NAMESPACE="$1"
RELEASE="$2"

echo "=== CLEANUP SCRIPT FOR MASAIC-CLOUD ==="

echo "1. Uninstalling Helm release '$RELEASE' (if exists)..."
helm uninstall $RELEASE -n $NAMESPACE || true

echo "2. Deleting Deployments..."
kubectl delete deployment masaic-platform -n $NAMESPACE --ignore-not-found
kubectl delete deployment masaic-platform-ui -n $NAMESPACE --ignore-not-found

echo "3. Deleting Services..."
kubectl delete service masaic-platform -n $NAMESPACE --ignore-not-found
kubectl delete service masaic-platform-ui -n $NAMESPACE --ignore-not-found

echo "4. Deleting Ingresses..."
kubectl delete ingress masaic-platform -n $NAMESPACE --ignore-not-found
kubectl delete ingress masaic-platform-ui -n $NAMESPACE --ignore-not-found

echo "5. Deleting any remaining ReplicaSets..."
kubectl delete replicaset -l app.kubernetes.io/instance=$RELEASE -n $NAMESPACE --ignore-not-found

echo "6. Deleting any remaining Pods..."
kubectl delete pod -l app.kubernetes.io/instance=$RELEASE -n $NAMESPACE --ignore-not-found

echo "7. Checking for remaining resources..."
kubectl get all -n $NAMESPACE || echo "No resources found in namespace $NAMESPACE"

echo ""
echo "=== CLEANUP COMPLETE ==="
echo "You can now run your Helm install command:"
echo "helm upgrade --install --n $NAMESPACE {release_name} ./helm --create-namespace"