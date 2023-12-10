#!/bin/bash

for file in "$1"; do ffmpeg  -hwaccel cuda -hwaccel_output_format nv12   -i "$file"  -c:v h264_nvenc    -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1      -c:a libfdk_aac  -b:a 96k -f matroska "${file%.*}_high.mkv"; done

# -preset slow  -bufsize 5M  -b:v 2M -preset slow   -filter:v scale=1280:-1 

# -s 720x480

#find . -name *.avi -or -name *.mkv -or -name *.mp4 -or -name *flv -exec ffmpeg  -hwaccel cuda -hwaccel_output_format nv12  -i {} -c:v h264_nvenc   -preset slow     -filter:v scale=1280:-1    -c:a libfdk_aac  -b:a 96k -f matroska  -c:a libfdk_aac  -b:a 96k -f matroska {}_high.mkv \;

