# Apptainer ROS

This repo has definition files and tools working with [ROS](https://www.ros.org/) and [Apptainer](http://apptainer.org/) (formerly called Singularity).

| File                       | Type    | OS              | Compatible ROS Distributions                |
|----------------------------|---------|-----------------|---------------------------------------------|
| almalinux8-ros             | Basic   | AlmaLinux 8     | Galactic, Humble, Rolling*                  |
| bionic-ros                 | Basic   | Ubuntu Bionic   | Melodic; Bionic, Crystal, Dashing, Eloquent |
| bullseye-ros               | Basic   | Debian Bullseye | Galactic, Humble, Rolling*                  |
| buster-ros                 | Basic   | Debian Buster   | Noetic; Foxy, Eloquent                      |
| focal-ros-galactic-desktop | Desktop | Ubuntu Focal    | Galactic                                    |
| focal-ros                  | Basic   | Ubuntu Focal    | Noetic; Foxy, Galactic, Humble, Rolling*    |
| jamy-ros-humble-desktop    | Desktop | Ubuntu Jammy    | Humble                                      |
| jammy-ros                  | Basic   | Ubuntu Jammy    | Humble, Rolling*                            |

`*` - Rolling's platforms change over time. See [REP 2000](https://ros.org/reps/rep-2000.html) for the most up to date info.

## Types of definition files
There are two kinds of definition files in this repository:

* Basic
* Desktop

Basic definition files have the tools to build or install ROS, but they don't come with ROS installed.
These are a good choice if yout want to build ROS from source, or avoid installing unnecessary packages.

Desktop definition files have all ROS packages up to `ros-$ROS_DISTRO-desktop` installed.
They're a good choice if you want to quickly use ROS.
