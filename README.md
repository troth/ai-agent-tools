# AI Agent Tools

Tools for setting up OpenCode and other AI tools to be run from within a docker
container so as to avoid polluting your workstation with npm and to restrict
the AI access to only the data for the task at hand.

This should also reduce the blast radius when things go horrible wrong with the
AI agents since they are not running directly on the host OS.

Before trying to build or run the container, be sure to setup the environment
needed by the container:

    $ ./setup-docker-env.sh


## Docker Data Storage

By default, docker is configured to use `/var/lib/docker` for data storage.
This is where it stores all images and volumes.

The docker compose file in this repository use a persistent volume for `ollama`
which will contain the pulled models.

Docker images and volumes can consume a significant about of disk space, so you
may want to consider moving the docker `data-root` configuration to another
disk if you are low on space on the partition where `/var/lib/docker` lives.

There are many resources on the internet which explain how to do this.

## Ollama Containers and GPU Configuration

In order to be able to run models in the GPU, you need to install and configure
the NVidia Container Toolkit on the host.

[Installing the NVidia Container Toolkit](
https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
)

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

If you don't specify a volume to mount into the workdir, any work you do in the
container will be lost when you exit the container.

The following shows how to map a single project into the workdir in the
container:

    $ ./image-run.sh -v $HOME/proj/foo:$HOME/workdir

The following shows how to map multiple projects into the workdir in the
container:

    $ ./image-run.sh \
            -v $HOME/proj/foo:$HOME/workdir/foo \
            -v $HOME/proj/bar:$HOME/workdir/bar \

You can also map files instead of directories:

    $ ./image-run.sh \
            -v $HOME/proj/foo/README.md:$HOME/workdir/README.md \
            -v $HOME/proj/foo/data.json:$HOME/workdir/data.json \

### Connecting Running Conntainer

Once you have start the `agents` container, you can make another connection to
it from another terminal with the following command:

    $ docker compose exec agents /bin/bash -l

## Running a local LLM

There are couple of ways to start the `ollama` container, but the following
works for me:

    $ docker compose run -P --rm ollama

The `-P` option is needed to map the 11434 ollama port into the host.

Convience script for running ollama:

    $ ./ollama-run.sh

Once the `ollama` container is running, can directly connect to the container
from the host with:

    $ docker compose exec ollama bash -l

Convenience script for connecting to the running ollama container (extra
arguments can be passed via the command line):

    $ ./ollama-shell.sh

If you have `ollama` installed on the host, you can also use it connect to the
`ollama` server running in the container:

    $ ollama list

### Installing Models

Once connected, you will need to install some models for `ollama` to use.

    $ ollama pull qwen2.5-coder:7b
    $ ollama pull qwen2.5-coder:3b
    $ ollama pull qwen3.6:27b
    $ ollama pull gemma4:e2b

### Using Models

Finally, you can run a model and enter prompts:

    $ ollama run <model>

## Using OpenCode

TBD
