#!/bin/bash

# Clean any existing videos in case a VM is reused for a build
rm "$MEDIA_PATH/*.avi"
rm "$MEDIA_PATH/*.mp4"