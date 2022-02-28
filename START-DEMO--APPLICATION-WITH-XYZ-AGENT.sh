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
    --name vulnerable-app-with-xyz-agent \
    --rm \
    -v $PWD/../xyz-agent/target/xyz-agent-1.0.jar:/xyz-agent-1.0.jar \
    vulnerable-app \
    java \
        -javaagent:/xyz-agent-1.0.jar \
        -DXYZ_AGENT_REPORT_URL=http://$HOST_IP:9411/api/v2/instrumentation-report \
        -jar /app/spring-boot-application.jar

