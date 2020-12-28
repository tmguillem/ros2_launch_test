#!/bin/bash

set -e

mkdir -p /home/ws/src
cp -r "$GITHUB_WORKSPACE"/* /home/ws/src

# Get Python version and major (e.g. python3.8)
python_ver=$(python3 -c 'import sys; print("python%d.%d" % (sys.version_info[0], sys.version_info[1]))')

SET(ENV{PYTHONPATH} "/opt/ros/dashing/lib/${python_ver}/site-packages/")

cd /home/ws
colcon build

ls -la 
pwd