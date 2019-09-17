# CircleCI locking

A circleCI worflow demonstrating locking - only 1 instance of this workflow can be running at a given time. If another attempts to start it will fail.

A simple shell script calls the CircleCI API to check if any other builds are running for this project, and fails the build if so.

##Requirements:
- Set the Environment Variable $CIRCLE_TOKEN in the circleCI project settings: https://circleci.com/docs/2.0/env-vars/#setting-an-environment-variable-in-a-project

All other env vars are set by Circle automatically.

##Try it:
To try it out, just branch this repo, and add it to your circleCI watched projects: `CircleCI Webpage > Add Projects > Set Up Project`
Start two builds at once, and the latter will fail if the first is still running.
