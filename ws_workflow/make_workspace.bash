#!/bin/bash

# Input:
#   path to definition file
#   currently located in an empty directory

function usage () {
  echo "Usage: $0 SINGULARITY_DEFINITION_FILE"
}

# Must have an argument
if [ $# -ne 1 ]
then
  echo "Wrong number of arguments"
  usage
  exit
fi

DEFINITION_FILE=$1

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

# Make sure the definition file exists and is readable
if [ ! -r "$DEFINITION_FILE" ]
then
  echo "Singularity definition file does not exist: $DEFINITION_FILE"
  usage
  exit
fi

# Make a `src` folder here
mkdir -p src

# Build the singularity sandbox
SANDBOX_NAME=$(basename $(echo $DEFINITION_FILE | sed -e 's/\(.def$\)\|\(.img$\)/.sandbox/'))
singularity build --fakeroot --sandbox "$SANDBOX_NAME/" "$DEFINITION_FILE"

# Create a mount for the `src` foulder inside the sandbox
singularity exec --fakeroot --writable "$SANDBOX_NAME" mkdir -p $(pwd)/src

# Copy the _scripts/ folder here
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cp -R "$DIR/_scripts" .

echo "Successfully created workspace in `pwd`"
