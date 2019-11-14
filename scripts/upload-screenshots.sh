#!/bin/bash

aws s3 sync $MEDIA_PATH s3://i.octopus.com/guides --acl public-read