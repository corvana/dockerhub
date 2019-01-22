FROM golang as gpbackup-s3-plugin-builder

ENV CHECKOUT=tags/1.1.0

RUN go get github.com/greenplum-db/gpbackup-s3-plugin; \
    cd /go/src/github.com/greenplum-db/gpbackup-s3-plugin && \
    git checkout ${CHECKOUT} && \
    make depend build unit

FROM golang as gpbackup-builder

ENV CHECKOUT=tags/1.9.0

RUN go get github.com/greenplum-db/gpbackup; \
    cd /go/src/github.com/greenplum-db/gpbackup && \
    git checkout ${CHECKOUT} && \
    make depend build unit

FROM ubuntu:xenial

ADD init.sh /root/
ADD start-singlenode.sh /gpdb/
ADD gpdb.bashrc /gpdb/.bashrc
ADD gpdb.bash_profile /gpdb/.bash_profile

RUN apt update && \
    apt install -y sudo software-properties-common gnupg locales && \
    add-apt-repository -y ppa:greenplum/db && \
    apt update && \
    apt dist-upgrade -y && \
    apt install -y greenplum-db-oss && \
    apt remove --purge -y software-properties-common && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g 4321 gpdb && \
    useradd -g 4321 -u 4321 --shell /bin/bash -d /gpdb gpdb && \
    chown -R gpdb /gpdb && \
    locale-gen en_US.UTF-8 && \
    mkdir /gpmaster /gpdata0 && \
    chown -R gpdb:gpdb /gpmaster /gpdata0

COPY --from=gpbackup-builder /go/bin/gpbackup /opt/gpdb/bin/gpbackup
COPY --from=gpbackup-builder /go/bin/gpbackup_helper /opt/gpdb/bin/gpbackup_helper 
COPY --from=gpbackup-builder /go/bin/gprestore /opt/gpdb/bin/gprestore
COPY --from=gpbackup-s3-plugin-builder /go/bin/gpbackup_s3_plugin /opt/gpdb/bin/gpbackup_s3_plugin

EXPOSE 5432
EXPOSE 22

ENTRYPOINT ["/root/init.sh"]
