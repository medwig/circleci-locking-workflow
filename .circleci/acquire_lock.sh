#!/usr/bin/env bash

CIRCLE_API='https://circleci.com/api/v1.1'
NONE="[ ]"

apiUrl="$CIRCLE_API/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME?shallow=true&limit=1&filter=running"
runningBuilds=$(curl -u $CIRCLE_TOKEN: "$CIRCLE_API/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME?shallow=true&limit=1&filter=running")

if [ "$runningbuilds" == "$none" ];
then
    echo 'No builds running, lock acquired.'
    exit 0
fi

echo "A build is running. Check if it is this build..."

isThisBuild=$(echo $runningbuilds | grep "build_num\" : $CIRCLE_BUILD_NUM")
if [ -z "$isThisBuild" ];
then
    echo 'Another build is running. Wait for it to finish'
    echo $runningBuilds
    exit 1
fi

echo "No other builds running. Lock acquired"