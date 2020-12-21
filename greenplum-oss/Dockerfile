FROM golang as gpbackup-s3-plugin-builder

ENV CHECKOUT=tags/1.6.0

RUN go get github.com/greenplum-db/gpbackup-s3-plugin; \
    cd /go/src/github.com/greenplum-db/gpbackup-s3-plugin && \
    git checkout ${CHECKOUT} && \
    make depend build unit

FROM golang as gpbackup-builder

FROM ubuntu:bionic

ADD init.sh /root/
ADD start-singlenode.sh /gpdb/
ADD gpdb.bashrc /gpdb/.bashrc
ADD gpdb.bash_profile /gpdb/.bash_profile

RUN apt update && \
    apt install -y sudo software-properties-common curl gnupg locales libapr1 libaprutil1 krb5-multidev libcurl3-gnutls libedit2 libevent-2.1-6 libyaml-0-2 openssh-client openssh-server perl rsync zip net-tools less iproute2 inetutils-ping unzip && \
    apt update && \
    apt dist-upgrade -y && \
    rm -rf /var/lib/apt/lists/* && \
    groupadd -g 4321 gpdb && \
    useradd -g 4321 -u 4321 --shell /bin/bash -d /gpdb gpdb && \
    chown -R gpdb /gpdb && \
    locale-gen en_US.UTF-8 && \
    mkdir /gpmaster /gpdata0 && \
    chown -R gpdb:gpdb /gpmaster /gpdata0 && \
    curl -SL -o greenplum-db.deb https://github.com/greenplum-db/gpdb/releases/download/6.11.2/greenplum-db-6.11.2-ubuntu18.04-amd64.deb && \
    dpkg -i greenplum-db.deb && \
    rm greenplum-db.deb && \
    curl -SL -o /usr/local/greenplum-db-6.11.2/bin/gpbackup https://github.com/greenplum-db/gpbackup/releases/download/1.13.0/gpbackup && \
    curl -SL -o /usr/local/greenplum-db-6.11.2/bin/gpbackup_helper https://github.com/greenplum-db/gpbackup/releases/download/1.13.0/gpbackup_helper && \
    curl -SL -o /usr/local/greenplum-db-6.11.2/bin/gprestore https://github.com/greenplum-db/gpbackup/releases/download/1.13.0/gprestore && \
    chmod 555 /usr/local/greenplum-db-6.11.2/bin/gpbackup /usr/local/greenplum-db-6.11.2/bin/gpbackup_helper /usr/local/greenplum-db-6.11.2/bin/gprestore

COPY --from=gpbackup-s3-plugin-builder /go/bin/gpbackup_s3_plugin /usr/local/greenplum-db-6.11.2/bin/gpbackup_s3_plugin

EXPOSE 5432
EXPOSE 22

ENTRYPOINT ["/root/init.sh"]
