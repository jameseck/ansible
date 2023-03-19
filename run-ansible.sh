#!/bin/bash

CONTAINER_USER=$(id -u)

podman run \
  -it \
  -u "${CONTAINER_USER}" \
  --security-opt label=disable \
  --userns=keep-id \
  -e SSH_AUTH_SOCK=/ssh-agent \
  -e HOME=/home/default \
  -v "${SSH_AUTH_SOCK}:/ssh-agent:Z" \
  -v "${HOME}/.ssh:/home/default/.ssh:Z" \
  -v "$(pwd):/data:Z" \
  --entrypoint bash \
  ghcr.io/jameseck/ansible210:latest \
  $@

