# AI Agent Tools

Tools for setting up OpenCode and other AI tools to be run from within a docker
container so as to avoid polluting your workstation with npm and to restrict
the AI access to only the data for the task at hand.

This should also reduce the blast radius when things go horrible wrong with the
AI agents since they are not running directly on the host OS.

Before trying to build or run the container, be sure to setup the environment
needed by the container:

    $ ./setup-docker-env.sh

## Container Creation

To build the container image with docker compose:

    $ docker compose build

To force a rebuild of layers:

    $ docker compose build --no-cache

A convenience script to make it easier to do the build is provided:

    $ ./image-build.sh
    $ ./image-build.sh --no-cache

## Running the Container

To run the container:

    $ docker compose run --rm agents

To run the container mounting a specific project into the container onto the
$HOME/workdir inside the container:

    $ docker compose run --rm -v ${HOME}/proj/foo:${HOME}/workdir agents

Again, a convenience script to make it easier to run the containers is provided:

    $ ./image-run.sh
    $ ./image-run.sh -f compose-vim-cfg.yaml

If you don't specify a volume to mount into the workdir, any work you do in the
container will be lost when you exit the container.

The following shows how to map a single project into the workdir in the
container:

    $ ./image-run.sh -f compose-vim-cfg.yaml \
            -v $HOME/proj/foo:$HOME/workdir

The following shows how to map multiple projects into the workdir in the
container:

    $ ./image-run.sh -f compose-vim-cfg.yaml \
            -v $HOME/proj/foo:$HOME/workdir/foo \
            -v $HOME/proj/bar:$HOME/workdir/bar \

You can also map files instead of directories:

    $ ./image-run.sh -f compose-vim-cfg.yaml \
            -v $HOME/proj/foo/README.md:$HOME/workdir/README.md \
            -v $HOME/proj/foo/data.json:$HOME/workdir/data.json \

## Running a local LLM

TBD

## Using OpenCode

TBD
