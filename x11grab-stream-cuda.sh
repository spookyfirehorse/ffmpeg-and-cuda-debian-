#!/bin/bash
#ffmpeg -y  -threads 4 -hide_banner -f pulse -ac 2 -i default -f x11grab -framerate 25 -video_size 1920x1080 -i :0.0+0,0 -c:v h264_nvenc  -pix_fmt yuv420p -qp 0 -preset fast -b:v 1400k -c:a libfdk_aac -b:a 128k  -ar 44100  -af aresample=async=1:min_hard_comp=0.100000:first_pts=0  /home/tom/Video.mkv
ffmpeg -vsync 0 -hide_banner  -hwaccel cuda -hwaccel_output_format cuda  \
  -f pulse -ac 2 -i alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.pro-output-0.monitor  \
  -f x11grab -r 30  -video_size 1920x1080 -i :0.0+0,0 -c:v h264_nvenc  \
   -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 \
  -c:a libfdk_aac -b:a 96k  -ar 48000   -f rtsp rtsp://localhost:8559/mystream






#Command Line for Latency-Tolerant High-Quality Transcoding
#Input: input.mp4

#Output: same resolution as input, bitrate = 5M (audio same as input)

#Slow Preset
#ffmpeg -y -vsync 0 -hwaccel cuda -hwaccel_output_format cuda -i input.mp4 -c:a copy -c:v h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 output.mp4

#Medium Preset
#Use -preset p4 instead of -preset p6 in the above command line.

#Fast Preset
#Use -preset p2 instead of -preset p6 in the above command line.


#Command Line for Low Latency Transcoding
#Input: input.mp4 (30fps)

#Output: same resolution as input, bitrate = 5M (audio same as input)

#Low Latency High Quality
#ffmpeg -y -vsync 0 -hwaccel cuda -hwaccel_output_format cuda -i input.mp4 -c:a copy -c:v h264_nvenc -preset p6 -tune ll -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 output.mp4

#Low Latency High performance
#Use -preset p2 instead of -preset p6 in above command line.
