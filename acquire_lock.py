#!/usr/bin/python3

import os
import sys
import json
try:
    from urllib.parse import urlencode
    from urllib.request import urlopen
    from urllib.request import Request
except ImportError:
    from urllib import urlencode
    from urllib2 import urlopen
    from urllib2 import Request


LOCK_FAIL_MSG = "Another build is running, wait for it to finish"
LOCK_PASS_MSG = "No other builds are running. Lock acquired"

headers = {'Accept': 'application/json'}
params = {
    'limit': 2,
    'filter': 'running'
    }
url = 'https://circleci.com/api/v1.1/project/github/{user}/{repo}?shallow=true&{params}'.format(
    user=os.environ["CIRCLE_PROJECT_USERNAME"],
    repo=os.environ["CIRCLE_PROJECT_REPONAME"],
    params=urlencode(params)
)
req = Request(url, headers=headers)
response = urlopen(req)
running_builds = json.loads(response.read().decode('utf-8'))

print('\nRunning Builds:\n', running_builds, '\n')

# No builds running - pass
if not running_builds:
    print(LOCK_PASS_MSG)
    sys.exit()

# Multiple running builds - fail
assert len(running_builds) < 2, LOCK_FAIL_MSG

# This build is the only one running - pass
CIRCLE_BUILD_NUM = int(os.environ['CIRCLE_BUILD_NUM'])
assert running_builds[0]["build_num"] == CIRCLE_BUILD_NUM, LOCK_FAIL_MSG

# All asserts met - pass
print(LOCK_PASS_MSG)
