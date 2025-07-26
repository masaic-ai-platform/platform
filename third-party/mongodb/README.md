# MongoDB Third-Party Deployment

This chart deploys MongoDB using the MongoDB Community Operator.

## Prerequisites

1. Add MongoDB Helm repository:
```bash
helm repo add mongodb https://mongodb.github.io/helm-charts
helm repo update
```

2. Install CRDs first:
```bash
helm install community-operator-crds mongodb/community-operator-crds -n masaic-cloud --create-namespace
```

## Installation

1. Install MongoDB with the community operator:
```bash
helm upgrade --install -n masaic-cloud mongodb-third-party ./third-party/mongodb --create-namespace
```

## Connection Details

- **Service Name**: `mongodb`
- **Username**: `mongodb-user`
- **Password**: `mongodb-admin-password-123` (configurable in values.yaml)
- **Connection String**: `mongodb://mongodb-user:mongodb-admin-password-123@mongodb:27017/`

## Configuration

Update `values.yaml` to customize:
- `mongoDb.secrets.adminPassword`: MongoDB admin password
- Other MongoDB operator settings as needed

## Verification

Check if MongoDB is running:
```bash
kubectl get pods -n masaic-cloud | grep mongodb
kubectl get mongodbcommunity -n masaic-cloud
``` 