from quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.20.0

USER root
RUN apt update && \
    apt remove gdb -y && \
    apt autoremove -y && \
    apt dist-upgrade -y && \
    rm -rf /var/lib/apt/lists/*
USER www-data
