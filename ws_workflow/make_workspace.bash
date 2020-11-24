#!/bin/bash

# Input:
#   path to definition file
#   currently located in an empty directory

function usage () {
  echo "Usage: $0 SINGULARITYTHING"
}

# Must have an argument
if [ $# -ne 1 ]
then
  echo "Wrong number of arguments"
  usage
  exit
fi

# Could be a path to a definition file, image, sandbox, library URI, or docker URI
SINGULARITY_THING=$1

# Check if current directory is empty
if [ "$(ls -A $(pwd))" ]
then
  echo "----------------------------"
  echo "Warning, `pwd` is not empty."
  ls --color=always --group-directories-first -A | sed -e 's/^/\t/'
  echo "Would you like to create a workspace here anyways?"

  select yn in "Yes" "No"; do
      case $yn in
          Yes ) break;;
          No ) exit;;
      esac
  done
  echo "----------------------------"
fi

if [ -r "$SINGULARITY_THING" ]
then
  # If it's a definition file or imagethat's readable
  SANDBOX_NAME=$(basename $(echo $SINGULARITY_THING | sed -e 's/\(.def$\)\|\(.img$\)/.sandbox/'))
else
  # Assume it's something else, like a docker or library URI
  SANDBOX_NAME=$(echo $SINGULARITY_THING | sed -e "s/^library:\/\///" | sed -e "s/^docker:\/\///" | sed -e "s/\//./g" | sed -e "s/:/./" | sed -e "s/\.\././g" | sed -e "s/$/.sandbox/")
fi

# Make a `src` folder here
mkdir -p src

# Build the singularity sandbox
singularity build --fakeroot --sandbox "$SANDBOX_NAME/" "$SINGULARITY_THING"

# Create a mount for the `src` foulder inside the sandbox
singularity exec --fakeroot --writable "$SANDBOX_NAME" mkdir -p $(pwd)/src

# Copy the _scripts/ folder here
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cp -R "$DIR/_scripts" .

echo "Successfully created workspace in `pwd`"
