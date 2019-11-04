#!/usr/bin/env bash

docker stop legacy-kops &> /dev/null;
docker rm legacy-kops &> /dev/null;

if [ ! -f config ]; then
    echo "missing config"
    exit 1
fi

if [ ! -f credentials ]; then
    echo "missing credentials"
    exit 1
fi

docker build -t legacy-kops .
docker run -ti legacy-kops bash 
