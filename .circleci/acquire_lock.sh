#!/usr/bin/env bash

CIRCLE_API='https://circleci.com/api/v1.1'
NONE="[ ]"

apiUrl="$CIRCLE_API/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME?shallow=true&limit=1&filter=running"
runningBuilds=$(curl -u $CIRCLE_TOKEN: "$CIRCLE_API/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME?shallow=true&limit=1&filter=running")

if [ "$runningBuilds" == "$NONE" ];
then
    echo 'No builds running, lock acquired.'
    exit 0
else
    echo 'A build is running, wait for it to finish'
    echo $runningBuilds
    exit 1
fi