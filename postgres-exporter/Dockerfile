FROM golang as builder

ARG REPO=github.com/corvana/postgres_exporter
ARG VERSION=v0.4.7
ARG TAG_SUFFIX=-no-pg-settings

RUN go get ${REPO}; \
    cd /go/src/${REPO} && \
    git checkout tags/${VERSION}${TAG_SUFFIX} && \
    go run mage.go binary && \
    chmod +X /go/src/${REPO}/bin/postgres_exporter_${VERSION}_linux-amd64/postgres_exporter && \
    mv /go/src/${REPO}/bin/postgres_exporter_${VERSION}_linux-amd64/postgres_exporter /postgres_exporter

FROM scratch
COPY --from=builder /postgres_exporter /postgres_exporter
EXPOSE 9187
ENTRYPOINT [ "/postgres_exporter" ]
