FROM registry.access.redhat.com/ubi8/python-38:latest

ENV HOME=/home/default

WORKDIR /home/default
USER 0
RUN \
  dnf -y install jq unzip && \
  dnf clean all -y && \
  mkdir -m 0775 /data && \
  chown -R 1001:0 /data && \
  usermod -d /home/default default && \
  chmod 0770 /home/default && \
  chown -R 1001:0 /home/default && \
  curl -Lo /tmp/bw-linux.zip $(curl -s https://api.github.com/repos/bitwarden/clients/releases | jq -r 'first(.[] | select(.tag_name|test("cli-."))) | .assets[] | select(.name|test("bw-linux.*zip")) | .browser_download_url') && \
  unzip /tmp/bw-linux.zip -d /usr/local/bin/ && \
  chmod +x /usr/local/bin/bw

ADD requirements.txt /
USER 1001

# Install the dependencies
RUN pip install -U "pip>=23.0.1" && \
    pip install -r /requirements.txt

CMD bash
