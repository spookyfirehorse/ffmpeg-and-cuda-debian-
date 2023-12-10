#!/bin/bash

ffmpeg -vsync 0 -hide_banner  -hwaccel cuda -hwaccel_output_format nv12    \
-f pulse -ac 2 -i alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.pro-output-0.monitor  -f x11grab -framerate 30 -video_size 1920x1080 \
-i :0.0+0,0 -c:v h264_nvenc -preset p6 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1   \
-c:a libfdk_aac -b:a 96k  -ar 48000   `date +%Y-%m-%d-%H-%M`.mp4




#Low Latency High Quality

#ffmpeg -y -vsync 0 -hwaccel cuda -hwaccel_output_format cuda -i input.mp4  -c:v h264_nvenc -preset p6 -tune ll -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 -c:a libfdk_aac -b:a 128k  -ar 48000   `date +%Y-%m-%d-%H-%M`.mp4


#Use -preset p2 instead of -preset p6 in above command line.

###############

#ffmpeg -y -vsync 0 -hwaccel cuda -hwaccel_output_format cuda -i input.mp4  -c:v h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 -c:a libfdk_aac -b:a 128k  -ar 48000   `date +%Y-%m-%d-%H-%M`.mp4

#Use -preset p4 instead of -preset p6 in the above command line.

