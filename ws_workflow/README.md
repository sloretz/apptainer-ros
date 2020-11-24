# Singularity ROS - Workspace Workflow

How should ROS workspaces and singularity be used together?
This presents a workflow that works for developing with ROS.

## What to do

This section is meant to be used as a reference in case you forget a command.
It may be helpful to [read about how it works](#how-it-works) as well.

### First time workspace setup

This will set up a workspace for developing using [ROS Rolling Ridley](https://index.ros.org/doc/ros2/Releases/#rolling-distribution).

1. Make an empty workspace folder
    ```bash
    mkdir -p ~/my_new_ws
    ```
1. Create a singularity workspace from some kind of definition file or image.
    ```bash
    cd ~/my_new_ws/
    # OPTION 1: Use one of the definition files in this repo
    path/to/make_workspace.bash path/to/singularity-ros/definition_files/ros.focal.def

    # OPTION 2: Build on top of a docker image
    # path/to/make_workspace.bash docker://ros:rolling

    # OPTION 3: Build on top of another singularity sandbox
    # path/to/make_workspace.bash path/to/another/ros.focal.sandbox

    # OPTION 4: Build on top of a singularity image
    # path/to/make_workspace.bash path/to/some/ros.focal.img
    ```
1. Clone your ROS packages into the `src` folder
    ```bash
    cd ~/my_new_ws/src
    git clone https://github.com/ros2/examples.git
    ```
1.  Install your code's dependencies
    ```bash
    cd ~/my_new_ws/
    ./_scripts/rootshell.bash
    # You're now 'root' inside the container
    cd /path/to/my_new_ws/
    # Install system dependencies declared in package.xml's
    rosdep update
    apt update
    rosdep install --rosdistro rolling -yi --from-paths ./src
    # If you have any other system dependencies, now is the time to install them
    apt update && apt install -y libasio-dev
    ```

### Getting shells into your container

Your workspace is all set up!
These are the kinds of shells you can get to your container.

Use a normal shell to build, run, and test your workspace.

```bash
./_scripts/shell.bash
```

Use a root shell to install system dependencies.

```bash
./_scripts/rootshell.bash
```

Use an nvidia shell to run GUI programs or use your graphics card.

```bash
./_scripts/gui-nvidia-shell.bash
```

## How it works

This workflow chooses to:

* Use a singlarity sandbox as the storage for the container
* Let build and install artifacts live in the sandbox
* Use shell scripts to open terminals into the workspace
