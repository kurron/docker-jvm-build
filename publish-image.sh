#!/bin/bash

if [ "$1" = "" ]
then
 echo "Usage: $0 tag"
 exit
fi

TAG=$1

TAG_COMMAND="docker tag jvm-build:compose kurron/jvm-build:$TAG"
echo $TAG_COMMAND
$TAG_COMMAND

PUSH_COMMAND="docker push kurron/jvm-build:$TAG"
echo $PUSH_COMMAND
$PUSH_COMMAND
