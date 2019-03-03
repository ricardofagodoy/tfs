#!/usr/bin/env bash

docker-compose down -d server

sleep 10

docker-compose down db