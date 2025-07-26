# Third-Party Dependencies Installation Guide

This guide covers the installation of all third-party dependencies required for the Masaic Platform.

## Prerequisites

1. Kubernetes cluster with Helm installed
2. `kubectl` configured to access your cluster

## SigNoz Installation

SigNoz provides observability and monitoring for the platform.

### Installation Commands:
```bash
helm repo add signoz https://charts.signoz.io/
helm upgrade --install -n masaic-cloud masaic-signoz signoz/signoz --create-namespace
```

### Cleanup:
```bash
./scripts/cleanup.sh masaic-cloud masaic-signoz
```

### Official Documentation:
- [SigNoz Helm Charts](https://github.com/SigNoz/charts)

## Qdrant Installation

Qdrant provides vector search capabilities for the platform.

### Installation Commands:
```bash
helm repo add qdrant https://qdrant.to/helm
helm upgrade --install -n masaic-cloud masaic-qdrant qdrant/qdrant --create-namespace
```

### Cleanup:
```bash
./scripts/cleanup.sh masaic-cloud masaic-qdrant
```

### Official Documentation:
- [Qdrant Helm Charts](https://github.com/qdrant/qdrant-helm/tree/main)

## MongoDB Installation

MongoDB provides data persistence and vector storage for the platform.

### Installation Commands:
```bash
# Add MongoDB repository and install CRDs
helm repo add mongodb https://mongodb.github.io/helm-charts
helm repo update
helm upgrade --install -n masaic-cloud masaic-mongodb mongodb/community-operator-crds --create-namespace

# Install MongoDB using the community operator
helm upgrade --install -n masaic-cloud masaic-mongodb ./third-party/mongodb --create-namespace \
  --set mongoDb.secrets.adminPassword="admin_pwd"
```

### Cleanup:
```bash
./scripts/cleanup.sh masaic-cloud masaic-mongodb
```

### Official Documentation:
- [MongoDB Helm Charts](https://github.com/mongodb/helm-charts)

## Installation Order

For a complete setup, install dependencies in this order:

1. **SigNoz** (for monitoring)
2. **Qdrant** (for vector search)
3. **MongoDB** (for data persistence)
4. **Masaic Platform** (main application)

## Connection Details

After installation, the platform will connect to:

- **MongoDB**: `mongodb://mongodb-user:admin_pwd@mongodb-svc:27017/`
- **Qdrant**: `masaic-qdrant:6334`
- **SigNoz**: `masaic-signoz:4318`

## Verification

Check if all services are running:
```bash
kubectl get pods -n masaic-cloud
```

Expected services:
- `masaic-signoz-*` (SigNoz components)
- `masaic-qdrant-*` (Qdrant components)
- `mongodb-*` (MongoDB components)
- `masaic-platform-*` (Masaic Platform)
- `masaic-platform-ui-*` (Platform UI) 