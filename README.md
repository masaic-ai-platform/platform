# Masaic Dev Platform - Helm Chart

A Helm chart to deploy [OpenResponses](https://github.com/masaic-ai-platform/open-responses) and [Platform UI](https://github.com/masaic-ai-platform/platform-ui/) for an Agentic Orchestration AI platform.

## Quick Installation

```bash
git clone https://github.com/your-org/platform.git
cd platform
helm upgrade --install -n masaic-cloud my-release ./masaic --create-namespace
```

## Deployment Modes

### 1. Basic Setup (Default)
- In-memory DB, no vector store or external dependencies.
```bash
helm upgrade --install -n masaic-cloud my-release ./masaic --create-namespace
```

### 2. Production Setup
- Set the following variables in your `values.yaml` or with `--set`:
  - `openResponses.qdrant.apikey` (Qdrant API key)
  - `openResponses.platform.model.apikey` (Model API key)
  - `openResponses.mongoDb.uri` (MongoDB URI)
  - `openResponses.vectorRepositoryType` = `mongodb`
  - `openResponses.vectorSearchProvider` = `qdrant`
  - `openResponses.storeType` = `mongodb`
  - `openResponses.otel.endpoint` (OTEL collector endpoint)
  - `openResponses.otel.headersMap` (OTEL headers, e.g., API keys)

### 3. Built-in Secrets
- Use built-in secret management for API keys by setting:
  - `openResponses.qdrant.apikey`
  - `openResponses.platform.model.apikey`
  - `openResponses.mongoDb.secrets.adminPassword`
```bash
helm upgrade --install -n masaic-cloud my-release ./masaic --create-namespace \
  --set openResponses.qdrant.apikey="your_qdrant_api_key" \
  --set openResponses.platform.model.apikey="your_model_api_key" \
  --set openResponses.mongoDb.secrets.adminPassword="mongo_pwd"
```

**Note**: For third-party dependencies (MongoDB, SigNoz, Qdrant), see [third-party installation guide](./third-party/mongodb/README.md).

## Configuration

### Environment Variables

| Property | Description | Default | Options |
|----------|-------------|---------|---------|
| `openResponses.springProfile` | Spring profile for the application | `"platform"` | Always set to "platform" |
| `openResponses.vectorRepositoryType` | Type of vector repository | `"file"` | `"file"`, `"mongodb"` |
| `openResponses.vectorSearchProvider` | Vector search provider | `"file"` | `"file"`, `"qdrant"` |
| `openResponses.vectorSearchCollectionName` | Name of the vector search collection | `"openresponses"` | Custom string |
| `openResponses.storeType` | Storage type for model messages | `"in-memory"` | `"in-memory"`, `"mongodb"` |
| `openResponses.mongoDbDatabase` | MongoDB database name | `"openresponses"` | Custom string |
| `openResponses.qdrant.host` | Qdrant server host | `""` | Qdrant server URL |
| `openResponses.qdrant.port` | Qdrant server port | `6334` | Port number |
| `openResponses.qdrant.apikey` | Qdrant API key | `""` | API key string |
| `openResponses.qdrant.useTLS` | Enable TLS for Qdrant | `true` | `true`, `false` |
| `openResponses.mongoDb.uri` | MongoDB connection URI | `""` | MongoDB connection string |
| `openResponses.platform.model.apikey` | API key for the model provider | `""` | API key string |
| `openResponses.platform.model.name` | Model name to use | `"gpt-4.1-mini"` | Model identifier |
| `openResponses.otel.sdkDisabled` | Disable OTEL SDK | `false` | `true`, `false` |
| `openResponses.otel.endpoint` | OTEL collector endpoint | `""` | Collector URL |
| `openResponses.otel.headersMap` | OTEL headers (e.g., API keys) | `{}` | Key-value pairs |
| `platformui.openResponses.url` | URL for OpenResponses service | `"http://localhost:6644"` | Service URL |

### Service Ports
- **OpenResponses API**: Port 6644
- **Platform UI**: Port 6645

### Health Endpoints
- **OpenResponses**: `/actuator/health`
- **Platform UI**: `/health`

### Resource Limits Example
```yaml
openResponses:
  resources:
    requests:
      cpu: 2
      memory: 1Gi
    limits:
      cpu: 2
      memory: 1Gi
platformui:
  resources:
    requests:
      cpu: 1
      memory: 512Mi
    limits:
      cpu: 1
      memory: 512Mi
```

### Ingress Example
```yaml
openResponses:
  ingress:
    enabled: true
    hosts:
      - host: api.yourdomain.com
        paths:
          - path: /
            pathType: ImplementationSpecific
platformui:
  ingress:
    enabled: true
    hosts:
      - host: ui.yourdomain.com
        paths:
          - path: /
            pathType: ImplementationSpecific
```

## Troubleshooting
- Check pod status: `kubectl get pods -n masaic-cloud`
- View logs: `kubectl logs -n masaic-cloud deployment/masaic-platform`
- Check services: `kubectl get svc -n masaic-cloud`

## Cleanup
To remove all resources created by this chart, run:
```bash
./scripts/cleanup.sh
```
