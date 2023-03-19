FROM registry.access.redhat.com/ubi8/python-38:latest

ENV HOME=/home/default

WORKDIR /workdir
USER 0
RUN \
  mkdir -m 0770 /home/default && \
  chown -R 1001:0 /home/default && \
  usermod -d /home/default default && \
  chown -R 1001:0 /workdir && \
  chmod 0775 /workdir
ADD requirements.txt /
USER 1001

# Install the dependencies
RUN pip install -U "pip>=23.0.1" && \
    pip install -r /requirements.txt

CMD bash
