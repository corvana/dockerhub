FROM golang as builder
ENV VERSION=v0.4.7
RUN go get github.com/wrouesnel/postgres_exporter; \
    cd /go/src/github.com/wrouesnel/postgres_exporter && \
    git checkout tags/${VERSION} && \
    go run mage.go binary && \
    chmod +X /go/src/github.com/wrouesnel/postgres_exporter/bin/postgres_exporter_${VERSION}_linux-amd64/postgres_exporter && \
    mv /go/src/github.com/wrouesnel/postgres_exporter/bin/postgres_exporter_${VERSION}_linux-amd64/postgres_exporter /postgres_exporter

FROM alpine
COPY --from=builder /postgres_exporter /postgres_exporter
EXPOSE 9187
ENTRYPOINT ["/postgres_exporter"]
