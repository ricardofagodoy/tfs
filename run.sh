#!/usr/bin/env bash

docker-compose up -d db

sleep 10

docker-compose up server