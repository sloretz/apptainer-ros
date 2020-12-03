#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Change directory because it doesn't exist in container, and so won't be bound
cd $DIR
WS_DIR=$(realpath $DIR/..)

. __find_sandbox.bash

echo "GUI (Nvidia) shell into $SANDBOX"
exec singularity shell --nv --no-home --writable-tmpfs --bind "$WS_DIR/src" --pwd "$WS_DIR" "$SANDBOX"
