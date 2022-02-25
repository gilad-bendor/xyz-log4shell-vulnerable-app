#!/bin/bash
docker build . -t vulnerable-app
docker run -p 8080:8080 --name vulnerable-app --rm vulnerable-app
