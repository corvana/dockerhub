from quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.20.0

USER root
RUN apt update && \
    apt dist-upgrade -y && \
    rm -rf /var/lib/apt/lists/*
USER www-data
