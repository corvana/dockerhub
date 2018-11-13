#!/usr/bin/env bash

service ssh start
sudo -i -E -u gpdb "$@"
