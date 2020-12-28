#!/bin/bash

mkdir -p /home/ws/src
cp "$GITHUB_WORKSPACE"/* /home/ws/src

cd /home/ws
colcon build

ls -la 
pwd 