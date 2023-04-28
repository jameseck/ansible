#!/bin/bash
cd /data
bash -c "$(printf ' %q' "$@")"
