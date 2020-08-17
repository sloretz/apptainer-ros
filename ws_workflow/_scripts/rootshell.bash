#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Change directory because it doesn't exist in container, and so won't be bound
cd $DIR
WS_DIR=$DIR/..

. __find_sandbox.bash

echo "Root (admin) shell into $SANDBOX"
exec singularity shell --fakeroot --no-home --writable --bind "$WS_DIR/src" --pwd "$WS_DIR" "$SANDBOX"
