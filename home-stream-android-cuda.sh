#!/bin/bash
#ffmpeg  -re -hwaccel cuda -hwaccel_output_format nv12   -fflags +genpts+nobuffer+discardcorrupt -avioflags direct   -hide_banner -rtsp_transport tcp   -i rtsp://127.0.0.1:8080/h264_pcm.sdp -c:v h264_nvenc -b:v 1M  -preset p2 -tune ll  -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 -filter:v scale=720:-1   -bufsize 5M     -c:a libopus -b:a 64k -application lowdelay  -movflags +faststart -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream
ffmpeg   -hwaccel cuda -hwaccel_output_format nv12   -fflags +genpts+nobuffer+discardcorrupt   -hide_banner -rtsp_transport tcp   -i rtsp://127.0.0.1:8080/h264_pcm.sdp -c:v h264_nvenc -b:v 1M  -preset p1 -tune ll       -c:a libfdk_aac -b:a 64k  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream