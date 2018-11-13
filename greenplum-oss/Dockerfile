FROM ubuntu:xenial

ADD init.sh /root/
ADD start-singlenode.sh /gpdb/
ADD gpdb.bashrc /gpdb/.bashrc

RUN  apt update && \
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
     mkdir /gpmaster /gpdata1 /gpdata2 && \
     chown -R gpdb:gpdb /gpmaster /gpdata1 /gpdata2

EXPOSE 5432
EXPOSE 22

ENTRYPOINT ["/root/init.sh"]
