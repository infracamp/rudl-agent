FROM infracamp/kickstart-flavor-gaia:testing

ENV DEV_CONTAINER_NAME="rudl-agent"

ENV CONF_METRICS_HOST="http://rudl-metrics"
ENV CONF_CLUSTER_NAME="n/a"

ADD / /opt
RUN ["bash", "-c",  "chown -R user /opt"]
RUN ["/kickstart/flavorkit/scripts/start.sh", "build"]

ENTRYPOINT ["/kickstart/flavorkit/scripts/start.sh", "standalone"]
