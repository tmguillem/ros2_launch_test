#!/bin/bash

set -e
source "/opt/ros/$ROS_DISTRO/setup.bash"

mkdir -p /home/ws/src
cp -r -v "$GITHUB_WORKSPACE"/* /home/ws/src

# Get Python version and major (e.g. python3.8)
python_ver=$(python3 -c 'import sys; print("python%d.%d" % (sys.version_info[0], sys.version_info[1]))')

cd /home/ws
ls -la src
pwd
echo $PYTHONPATH

colcon build
