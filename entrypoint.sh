#!/bin/bash

set -e
source "/opt/ros/$ROS_DISTRO/setup.bash"

env
echo "Parameters"
echo $1 
echo $2
echo $3
echo $4
echo $5

mkdir -p $GITHUB_WORKSPACE/ws/src
cd $GITHUB_WORKSPACE

# Move all files inside ws/src
rsync -av --remove-source-files . ws/src --exclude ws

cd ws

# Set GUI_FLAG to False to be able to run the simulator in the container. TODO: pass this as an argument?
sed -i 's/GUI_FLAG = True/GUI_FLAG = False/' src/simulator/bullet_simulation/bullet_simulation/full_simulator.py

colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

source install/setup.bash

echo "Running in background: $1 $2"
ros2 run $1 $2 &

echo "Topic checks"