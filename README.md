# Rudl Agent

Rudl agent runs on each node and pushes system information about filesystem usage, traffic,
memory consumption etc. to a metrics host ([rudl-metrics](https://github.com/infracamp/rudl-metrics)).

It can also be configured to run routine tasks on the host node.

### Deployment

The easiest way is to deploy rudl-agent via stack/pod file:

```yaml
service:
  rudl-agent:
    image: infracamp/rudl-agent:testing
    volumes:
    - "/:/hostfs"
    environment:
    - "CONF_METRICS_HOST=https://metrics-host.cluster"
    - "CONF_CLUSTER_NAME=cluster1"
```

Or it can be run directly with docker command:

```bash
docker run -d -v "/:/hostfs" -e CONF_CLUSTER_NAME=my-host-name1 -e CONF_METRICS_HOST=http://metrics-host.cluster infracamp/rudl-agent:testing
```

### Configuration options

| Env-Variable                       | Description                                 |
|------------------------------------|---------------------------------------------|
| `CONF_METRICS_HOST` (required)     | The full url to the metrics host            |
| `CONF_CLUSTER_NAME`                | The name of the cluster (for grouping multiple Nodes in dashboards) Default: `n/a` |

