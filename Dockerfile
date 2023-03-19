FROM registry.access.redhat.com/ubi8/python-38:latest

ENV HOME=/home/default

WORKDIR /home/default
USER 0
RUN \
  mkdir -m 0775 /data && \
  chown -R 1001:0 /data && \
  usermod -d /home/default default && \
  chmod 0770 /home/default && \
  chown -R 1001:0 /home/default

ADD requirements.txt /
USER 1001

# Install the dependencies
RUN pip install -U "pip>=23.0.1" && \
    pip install -r /requirements.txt

CMD bash
