#!/bin/bash

# Clean any existing videos in case a VM is reused for a build
if [ -d "$MEDIA_PATH" ]; then
  rm "$MEDIA_PATH/*.avi"
  rm "$MEDIA_PATH/*.mp4"
fi