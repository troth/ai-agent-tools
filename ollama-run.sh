#!/bin/bash

set -x

docker compose run -P --rm ollama "$@"
