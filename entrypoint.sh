#!/bin/bash

set -e
source "/opt/ros/$ROS_DISTRO/setup.bash"

mkdir -p /home/ws/src
cp -r "$GITHUB_WORKSPACE" /home/ws/src

# Set GUI_FLAG to False to be able to run the simulator in the container. TODO: pass this as an argument?
sed -i 's/GUI_FLAG = True/GUI_FLAG = False/' /home/ws/src/project_ace/simulator/bullet_simulation/bullet_simulation/full_simulator.py

cd /home/ws
colcon build

source install/setup.bash

echo "Running: $1 $2"
ros2 run $1 $2 