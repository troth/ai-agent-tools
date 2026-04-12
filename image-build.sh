#!/bin/bash
#
# Build time image.
#
# TIP: Use `--no-cache` to force the rebuilding of all layers even if they
# have not changed.
#

set -x
exec docker compose build "$@"
