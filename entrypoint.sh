#!/bin/bash

set -e
source "/opt/ros/$ROS_DISTRO/setup.bash"

mkdir -p /home/ws/src
cp -r "$GITHUB_WORKSPACE" /home/ws/src

cd /home/ws
colcon build

