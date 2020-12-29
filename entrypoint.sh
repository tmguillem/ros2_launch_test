#!/bin/bash

set -e
env

mkdir -p $GITHUB_WORKSPACE/ws/src
cd $GITHUB_WORKSPACE

# Move all files inside ws/src
rsync -aq --remove-source-files . ws/src --exclude ws

cd ws

# Set GUI_FLAG to False to be able to run the simulator in the container. TODO: pass this as an argument?
sed -i 's/GUI_FLAG = True/GUI_FLAG = False/' src/simulator/bullet_simulation/bullet_simulation/full_simulator.py

# Compile and source workspace packages
source "/opt/ros/$ROS_DISTRO/setup.bash"
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
source install/setup.bash

# Run requested launchfile
echo "Running in background: $INPUT_PACKAGE $INPUT_LAUNCHFILE"
ros2 launch $INPUT_PACKAGE $INPUT_LAUNCHFILE &>/dev/null &

ros2 topic list --include-hidden-topics

# Record short rosbag (timeout after 10 seconds)
# Currently it is not possible to record individual hidden topics, so we need to record all.
ros2 bag record -a --include-hidden-topics -o health_check_bag &>/dev/null &
sleep 10 && kill -INT $!

echo "Recording complete"
ros2 bag info health_check_bag

# Check topics
echo "Checking topics:"
for word in $INPUT_LISTEN_TOPICS
do
    echo $word
done