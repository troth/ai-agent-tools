#!/bin/bash

cat <<EOF >.env
# This file was generated using ./setup-docker-env.sh.
# The following environment variables are used by 'docker compose'.

MY_USERNAME=${USER}
MY_UID=$(id -u)
MY_GID=$(id -g)
EOF
