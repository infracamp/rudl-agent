# Rudl Agent

## Collect metrics from Host system


### Deployment


```yaml
service:
  rudl-agent:
    image: infracamp/rudl-agent:testing
    volumes:
    - "/:/hostfs"
    environment:
    - "CONF_CLUSTER_NAME=cluster1"
    - "CONF_METRICS_HOST=https://metrics-host.cluster"

```