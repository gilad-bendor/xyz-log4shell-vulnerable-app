#!/bin/bash -e

# Optionally build the docker. Always build if the docker is not yet built.
if [[ "$1" == "--build" ]] || ( ! docker image ls vulnerable-app | grep -q "^vulnerable-app" ) ; then
  docker build . -t vulnerable-app
else
  echo 'Skipping docker build - as image already exists. Pass "--build" to force build.'
fi

HOST_IP="$( ifconfig | grep "\binet\b" | grep -vF 127.0.0.1 | head -1 | sed -e 's/.*inet  *//' -e 's/ .*//' )"
set -x
docker run \
    -p 8080:8080 \
    --name vulnerable-app \
    --rm \
    vulnerable-app
