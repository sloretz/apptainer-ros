# Singularity ROS - Workspace Workflow

How should ROS workspaces and singularity be used together?
This presents a workflow that has worked well for development on multiple versions of ROS.

## What to do

This part is meant to be used as a reference.
It may be helpful to [read about how it works](#How_it_works) as well.

### First time workspace setup

1. Make a workspace folder, and a `src` folder inside of that
    ```console
    mkdir -p ~/my_new_ws/src
    ```
1. Clone your ROS packages into the `src` folder
    ```console
    cd ~/my_new_ws/src
    git clone https://github.com/ros2/examples.git
    ```
1. Create a fakeroot singularity sandbox from one of the definition files
    ```console
    cd ~/my_new_ws/
    # Assumes singularity-ros is in your `$HOME` folder
    singularity build --fakeroot --sandbox ros.focal.sandbox/ ~/singularity-ros/definition_files/ros.focal.def
    ```
1.

## How it works

This workflow chooses to:

* Use a singlarity sandbox as the storage for the container
* Let build and install artifacts live in the sandbox
* Use shell scripts to open terminals into the workspace
