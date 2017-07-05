#!/bin/bash

set -x
set -e

IMAGEVERSION=3.1.1.1

NAME=$(basename "$PWD")
docker build -t dayglo/$NAME:$IMAGEVERSION .

#docker build --no-cache -t dayglo/$NAME:$IMAGEVERSION .

docker tag dayglo/$NAME:$IMAGEVERSION dayglo/$NAME:latest