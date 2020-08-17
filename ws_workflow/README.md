# Singularity ROS - Workspace Workflow

How should ROS workspaces and singularity be used together?
This presents a workflow that works for developing with ROS.

## What to do

This section is meant to be used as a reference in case you forget a command.
It may be helpful to [read about how it works](#how-it-works) as well.

### First time workspace setup

This will set up a workspace for developing using [ROS Rolling Ridley](https://index.ros.org/doc/ros2/Releases/#rolling-distribution).

1. Make a workspace folder, and a `src` folder inside of that
    ```bash
    mkdir -p ~/my_new_ws/src
    ```
1. Create a fakeroot singularity sandbox from one of the definition files
    ```bash
    cd ~/my_new_ws/
    # Assumes singularity-ros is in your `$HOME` folder
    singularity build --fakeroot --sandbox ros.focal.sandbox/ ~/singularity-ros/definition_files/ros.focal.def
    ```
1. Create a mount for the `src` folder inside the sandbox
    ```bash
    cd ~/my_new_ws/
    # Make a mount point for `src` inside the container
    singularity exec --fakeroot --writable ros.focal.sandbox mkdir -p $(pwd)/src
    # Make the mount point owned by you - the user who will use the workspace
    singularity exec --fakeroot --writable ros.focal.sandbox chown -R $(whoami) $(pwd)
    sudo chown -R $(id -u):$(id -g) ./ros.focal.sandbox/$(pwd)/..
    ```
1. Copy scripts to the workspace, next to the `src` folder
    ```bash
    # Assumes singularity-ros is in your `$HOME` folder
    cp -R ~/singularity-ros/ws_workflow/_scripts ~/my_new_ws/
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
    # Install system dependencies declared in package.xml's
    rosdep update
    rosdep install --rosdistro rolling -ryi --from-paths ./src
    # If you have any other system dependencies, now is the time to install them
    sudo apt update && apt install -y this-is-not-a-real-package-name-put-your-stuff-here
    ```

### Getting shells into your container

Your container and workspace is all set up!
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
