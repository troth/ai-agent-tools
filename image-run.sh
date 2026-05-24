#!/bin/bash
#
# Runs then container.
#
# Useful additional options to pass:
#
#   -f docker-compose-vim-cfg.yaml
#
# You can pass multiple compose files to stack things.
#
# Use volumes to mount directories or files into the container to allow the AI
# agents to access them (by default the container has no access to files on the
# host os, you need to specify what is available in the container).
#
#   -v $HOME/projects/foo:$HOME/workdir/foo
#
# Volumes can also be defined in the compose files for cases where you want
# multiple directories or files accessible within the container. Especially
# useful when the paths are long and you don't want to type them repeatedly.
#

# These args most come before the `run` command in the docker compose command.
COMPOSE_ARGS=(
    -f compose.yaml
)

for yaml in compose.yaml.d/*.yaml
do
    if [[ -e ${yaml} ]]; then
        COMPOSE_ARGS+=( -f ${yaml} )
    fi
done

# These args must come after the `run` command.
RUN_ARGS=( )

while test -n "$1"
do
    arg="$1"
    case "$arg" in
        -f)
            COMPOSE_ARGS+=( "${arg}" "${2:?}" )
            shift
            ;;
        *)
            RUN_ARGS+=( "${arg}" )
            ;;
    esac
    shift
done

set -x
exec docker compose "${COMPOSE_ARGS[@]}" run --rm "${RUN_ARGS[@]}" agents
