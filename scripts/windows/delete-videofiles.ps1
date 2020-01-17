if (Test-Path $env:MEDIA_PATH -PathType Container) {
    rm "$($env:MEDIA_PATH)\*.avi"
    rm "$($env:MEDIA_PATH)\*.mp4"
}