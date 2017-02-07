#!/usr/bin/env bash

dir=$(pwd)

echo $dir

gnome-terminal -x  $dir/util/prepare-target.sh

echo "sleep 10"
sleep 10
