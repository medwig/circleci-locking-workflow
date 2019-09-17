#!/usr/bin/env bash

CIRCLE_API='https://circleci.com/api/v1.1'

apiUrl="$CIRCLE_API/project/github/$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME?shallow=true&limit=1&filter=running"
runningBuilds=$(curl -u $CIRCLE_TOKEN: -H "Accept: application/json" "$apiUrl")

# If no build is running the response will be "[]" (length=2)
if [ ${#runningBuilds} -eq 2 ];
then
    echo 'No builds running, lock acquired.'
    exit 0
fi

echo "A build is running. Check if it is this build..."

echo $runningBuilds
echo "build_num\":$CIRCLE_BUILD_NUM,"

if [[ $runningBuilds == *"build_num\":$CIRCLE_BUILD_NUM"* ]]
then
    echo "Only this build is running. Lock acquired"
    exit 0
else
    echo 'Another build is running. Wait for it to finish'
    exit 1

fi