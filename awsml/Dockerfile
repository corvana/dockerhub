FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y bash python2.7 python-pip python-tk && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /python && \
    groupadd -g 4567 python && \
    useradd -g 4567 -u 4567 --shell /bin/bash -d /python python && \
    chown -R python /python

COPY requirements.txt /

RUN pip install -r /requirements.txt && \
    rm -rf /root/.cache 

USER python
WORKDIR /python

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
