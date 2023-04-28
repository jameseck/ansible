FROM registry.access.redhat.com/ubi8/python-38:latest

ARG ANSIBLE_VERSION

ENV HOME=/home/default

WORKDIR /home/default
USER 0

ADD requirements_{ANSIBLE_VERSION}.txt /
ADD bw /usr/local/bin

RUN \
  dnf -y install jq unzip nmap-ncat && \
  dnf clean all -y && \
  mkdir -m 0775 /data && \
  chown -R 1001:0 /data && \
  usermod -d /home/default default && \
  chmod 0770 /home/default && \
  chown -R 1001:0 /home/default && \
  curl -Lo /tmp/bw-linux.zip $(curl -s https://api.github.com/repos/bitwarden/clients/releases | jq -r 'first(.[] | select(.tag_name|test("cli-."))) | .assets[] | select(.name|test("bw-linux.*zip")) | .browser_download_url') && \
  unzip /tmp/bw-linux.zip -d /tmp && \
  mv /tmp/bw /usr/local/bin/bwcli && \
  chmod +x /usr/local/bin/bwcli /usr/local/bin/bw

USER 1001

# Install the dependencies
RUN pip install -U "pip>=23.0.1" && \
    pip install -r /requirements_{ANSIBLE_VERSION}.txt

ADD --chmod=0755 run.sh /

ENTRYPOINT ["/run.sh"]
