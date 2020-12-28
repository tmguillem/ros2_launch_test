#!/bin/bash

set -e

mkdir -p /home/ws/src
cp -r "$GITHUB_WORKSPACE"/* /home/ws/src

cd /home/ws
colcon build

ls -la 
pwd 