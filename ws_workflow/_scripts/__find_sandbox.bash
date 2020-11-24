#!/bin/bash
set -e

# Assumes the current working directory is the _scripts folder
# Sets the variable SANDBOX to the path to the singularity sandbox, or
# exits with return code 1 if no such sandbox was found.

SANDBOX=$(find ../ -maxdepth 1 -name "*.sandbox")

if [ ! -d "$SANDBOX" ];
then
  if [ -z "$SANDBOX"];
  then
    echo "Did not find a directory ending in '.sandbox' to use as singularity sandbox" >&2
    exit 1
  else
    echo "Found more than one directory ending in '.sandbox': '$SANDBOX'" >&2
    exit 1
  fi
fi

# absolute path https://stackoverflow.com/a/3915420
SANDBOX="$(cd "$(dirname "$SANDBOX")"; pwd -P)/$(basename "$SANDBOX")"
