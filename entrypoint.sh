#!/bin/bash

set -e
env

cd "$GITHUB_WORKSPACE"/ros_ws

# Compile and source workspace packages
source "/opt/ros/$ROS_DISTRO/setup.bash"
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
source install/setup.bash

# Run requested launchfile
echo "Running in background: $INPUT_PACKAGE $INPUT_LAUNCHFILE"
ros2 launch "$INPUT_PACKAGE" "$INPUT_LAUNCHFILE" "$INPUT_ROS_ARGS" &>/dev/null &

ros2 topic list --include-hidden-topics

# Record short rosbag (timeout after 10 seconds)
# Currently it is not possible to record individual hidden topics, so we need to record all.
bag_name='health_check_bag'
ros2 bag record -a --include-hidden-topics -o $bag_name &>/dev/null &
sleep 10 && kill -INT $!

echo "Recording complete"
ros2 bag info $bag_name

# Check topics
if python3 /rosbag_health_checker.py --topic_checks $INPUT_LISTEN_TOPICS --bag_name $bag_name; then
    echo "The ROS2 health checker script returned status 0."
else
    echo "The ROS2 health checker script did not pass all tests."
    exit 64
fi