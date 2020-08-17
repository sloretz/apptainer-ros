#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# Change directory because it doesn't exist in container, and so won't be bound
cd $DIR
exec singularity shell --fakeroot --no-home --writable --bind /home/sloretz/ws/ros3/src --pwd /home/sloretz/ws/ros2 ../ros.focal.sandbox
