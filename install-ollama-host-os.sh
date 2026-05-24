#!/bin/bash

set -x

rm -rf $HOME/.opt/ollama
mkdir -p $HOME/.opt/ollama
curl -fsSL https://ollama.com/download/ollama-linux-amd64.tar.zst \
    | tar -C $HOME/.opt/ollama -xf - --zstd
