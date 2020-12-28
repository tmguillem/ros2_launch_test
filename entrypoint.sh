#!/bin/bash

set -e
source "/opt/ros/$ROS_DISTRO/setup.bash"

echo "Hello $1"
echo "Hello $2"

mkdir -p /home/ws/src
cp -r "$GITHUB_WORKSPACE" /home/ws/src

cd /home/ws
colcon build

source install/setup.bash

ros2 launch ace_scenario_bring_up juggling_bring_up.py