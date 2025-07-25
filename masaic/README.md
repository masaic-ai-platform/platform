
## Environment Variable Configuration for open-responses

The following environment variables can be configured for the `open-responses` service via `values.yaml`:

| Variable Name                                         | values.yaml Key                        | Default Value         | Description |
|-------------------------------------------------------|----------------------------------------|----------------------|-------------|
| SPRING_PROFILES_ACTIVE                                | openResponses.springProfile            | platform             | Spring profile to activate |
| OPEN_RESPONSES_STORE_VECTOR_REPOSITORY_TYPE           | openResponses.vectorRepositoryType     | mongodb              | Type of vector repository |
| OPEN_RESPONSES_STORE_VECTOR_SEARCH_PROVIDER           | openResponses.vectorSearchProvider     | qdrant               | Vector search provider |
| OPEN_RESPONSES_STORE_VECTOR_SEARCH_QDRANT_HOST        | openResponses.qdrant.host              | qdrant_host          | Qdrant host (service or external) |
| OPEN_RESPONSES_STORE_VECTOR_SEARCH_QDRANT_API_KEY     | openResponses.qdrant.apikey            | (blank)              | Qdrant API key |
| OPEN_RESPONSES_STORE_VECTOR_SEARCH_QDRANT_USE_TLS     | openResponses.qdrant.useTLS            | false                | Use TLS for Qdrant connection |
| OPEN_RESPONSES_STORE_VECTOR_SEARCH_COLLECTION_NAME    | openResponses.vectorSearchCollectionName| open_responses      | Qdrant collection name |
| OPEN_RESPONSES_STORE_TYPE                             | openResponses.storeType                | mongodb              | Store type for open-responses |
| OPEN_RESPONSES_MONGODB_URI                            | openResponses.mongoDb.uriSecret        | mongodb-admin-mongodb-user | MongoDB URI secret name (see below) |
| OPEN_RESPONSES_MONGODB_DATABASE                      | openResponses.mongoDbDatabase          | open_responses       | MongoDB database name |
| OTEL_SDK_DISABLED                                    | openResponses.otel.sdkDisabled         | false                | Disable OpenTelemetry SDK |
| OTEL_EXPORTER_OTLP_ENDPOINT                          | openResponses.otel.endpoint            | signoz_host          | OTEL collector endpoint |
| OTEL_EXPORTER_OTLP_HEADERS                           | openResponses.otel.headers             | (blank)              | OTEL collector headers |

### How to set these values

Edit `masaic/values.yaml` and set the values under the `openResponses` section. For example:

```yaml
openResponses:
  springProfile: "platform"
  vectorRepositoryType: "mongodb"
  vectorSearchProvider: "qdrant"
  vectorSearchCollectionName: "open_responses"
  storeType: "mongodb"
  mongoDbDatabase: "open_responses"
  qdrant:
    host: "qdrant_host"
    port: 6334
    apikey: ""
    useTLS: false
    secrets:
      create: true
  mongoDb:
    uriSecret: "mongodb-admin-mongodb-user"
  otel:
    sdkDisabled: false
    endpoint: "signoz_host"
    headers: ""
```

**Note:**
- `OPEN_RESPONSES_MONGODB_URI` is typically set via a Kubernetes Secret referenced by `openResponses.mongoDb.uriSecret`.
- All other variables can be set directly in `values.yaml`. 

## MongoDB Configuration

The platform chart requires a direct MongoDB URI to be provided in `values.yaml`:

```yaml
openResponses:
  mongoDb:
    uri: "mongodb://user:password@mongo-host:27017/dbname"
```

- The chart does not create or manage any MongoDB secrets.
- You are responsible for providing the correct URI (with credentials) for your MongoDB instance, whether it is in-cluster or external. 