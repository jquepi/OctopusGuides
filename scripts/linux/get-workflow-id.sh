#!/bin/bash

for (( c=1; c<=10; c++ ))
do
  WORKFLOW_ID=$(curl -s "https://api.github.com/repos/OctopusDeploy/OctopusGuides/actions/workflows?per_page=100&page=$c" | jq -c '.workflows[] | select(.name == "$GITHUB_WORKFLOW") | .id')
  if [[ -n $WORKFLOW_ID ]]; then
    # There are cases were the workflow name has been registered more than once
    # by mistake. Assume the first one is correct.
    stringarray=($WORKFLOW_ID)
    echo "::set-output name=WORKFLOW_ID::${stringarray[0]}"
    break
  fi
done