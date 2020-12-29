#!/bin/bash

set -e
source "/opt/ros/$ROS_DISTRO/setup.bash"

env

mkdir -p $GITHUB_WORKSPACE/ws/src
cd $GITHUB_WORKSPACE

# Move all files inside ws/src
rsync -aq --remove-source-files . ws/src --exclude ws

cd ws

# Set GUI_FLAG to False to be able to run the simulator in the container. TODO: pass this as an argument?
sed -i 's/GUI_FLAG = True/GUI_FLAG = False/' src/simulator/bullet_simulation/bullet_simulation/full_simulator.py

colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

source install/setup.bash

echo "Running in background: $INPUT_PACKAGE $INPUT_LAUNCHFILE"
ros2 run $INPUT_PACKAGE $INPUT_LAUNCHFILE &

echo "Checking topics:"
for word in $INPUT_LISTEN_TOPICS
do
    echo $word
done