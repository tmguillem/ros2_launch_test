#!/bin/bash

set -e
source "/opt/ros/$ROS_DISTRO/setup.bash"

mkdir -p $GITHUB_WORKSPACE/ws/src
cd $GITHUB_WORKSPACE

# Move all files inside ws/src
(shopt -s dotglob; cp -r !(ws) ws)
(shopt -s extglob; shopt -s dotglob; rm -v !(ws))

cd ws
ls -la src

# Set GUI_FLAG to False to be able to run the simulator in the container. TODO: pass this as an argument?
sed -i 's/GUI_FLAG = True/GUI_FLAG = False/' src/simulator/bullet_simulation/bullet_simulation/full_simulator.py

colcon build

source install/setup.bash

echo "Running: $1 $2"
ros2 run $1 $2 