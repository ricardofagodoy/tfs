#!/usr/bin/env bash

docker stop tfs-server

sleep 10

docker stop tfs-db

./clear.sh
