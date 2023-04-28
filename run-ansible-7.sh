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
  -v "${HOME}/.bitagent.sock:/home/default/.bitagent.sock:Z" \
  -v "${HOME}/.config/Bitwarden CLI:/home/default/.config/Bitwarden CLI:Z" \
  -v "${HOME}/.ssh:/home/default/.ssh:Z" \
  -v "$(pwd):/data:Z" \
  ghcr.io/jameseck/ansible-7.5.0:latest \
  bash -c "$(printf ' %q' "$@")"
