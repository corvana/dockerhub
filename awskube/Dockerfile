from alpine

run apk add --no-cache python3 curl && \
    pip3 install --upgrade pip && \
    pip3 install awscli && \
    curl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl > /bin/kubectl && \
    chmod 755 /bin/kubectl
