#!/usr/bin/env bash

apiUrl = "$CIRCLE_API/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME?shallow=true&limit=1&filter=running"
runningBuilds = $(curl -u $CIRCLE_TOKEN: "$CIRCLE_API/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME?shallow=true&limit=1&filter=running")

if [ -z "$runningBuilds" ]
then
      echo "No running builds, lock acquired"
      return 0
else
      echo "A build is running, waiting for it to finish"
      return 1
fi