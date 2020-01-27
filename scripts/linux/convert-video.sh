#!/bin/bash

VIDEO_FILES="$MEDIA_PATH/*.avi"

for f in $VIDEO_FILES
do
  echo "Processing $f"
  vlc -I dummy \
    "$f" \
    "--sout=#transcode{vcodec=h264,vb=1024,acodec=mp4a,ab=192,channels=2,deinterlace}:standard{access=file,mux=mp4,dst=\"${f%.*}.mp4\"}" \
    vlc://quit
done

#cd $MEDIA_PATH
# Remoave spaces from filenames
#find $1 -name "*.mp4" -type f -print0 | \
#  while read -d $'\0' f; do mv -v "$f" "${f// /_}"; done

VIDEO_FILE_LIST=($MEDIA_PATH/*.mp4)
echo "${VIDEO_FILE_LIST[@]}"

vlc -I dummy \
   "${VIDEO_FILE_LIST[@]}" \
   --no-sout-all \
   --sout-keep \
   --sout \
   "#gather:std{access=file,mux=mp4,dst=\"$MEDIA_PATH/video.mp4\"}" \
   vlc://quit

ffmpeg -i $MEDIA_PATH/video.mp4 -vf mpdecimate=max=30,setpts=N/FRAME_RATE/TB "$MEDIA_PATH/trimmed.mp4"
ffmpeg -i $MEDIA_PATH/video.mp4 "-filter:v" "setpts=0.75*PTS" "$MEDIA_PATH/fast.mp4"