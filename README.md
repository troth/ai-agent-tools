# AI Agent Tools

Instruction for setting up OpenCode to be run from within a docker container so
as to avoid polluting your workstation with npm and restricting AI access to
only the data for the task at hand.

Before trying to build or run the container, be sure to setup the environment
needed by the container:

    $ ./setup-docker-env.sh

## Container Creation

To build the container image with docker comppose:

    $ docker compose build

To force a rebuild of layers:

    $ docker compose build --no-cache

## Running the Container

To run the container:

    $ docker compose run --rm agent-tools

To run the container mounting a specific project into the container onto the
$HOME/workdir inside the container:

    $ docker compose run --rm -v ${HOME}/project/foobar:${HOME}/workdir agent-tools

## Running a local LLM

TBD

## Using OpenCode

TBD
