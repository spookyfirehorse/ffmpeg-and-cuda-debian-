## for file in *.mp4; do ffmpeg -i "$file"  -vcodec copy -acodec copy Videos/"${file%.mp4}.mp4"; done
#
### for file in *.mp4; do ffmpeg -i "$file"  -vcodec copy -acodec copy "${file%.mp4}_1.mp4"; done



#for file in *.mp4; do ffmpeg -hwaccel drm -i "$file"  -c:v h264_v4l2m2m -b:v 2M -pix_fmt yuv420p -c:a libfdk_aac  -b:a 96k -f mp4 /media/moon/convert/"${file%.mp4}.mp4"; done

#for file in *.mp4; do ffmpeg -hwaccel drm -i "$file"  -c:v h264_v4l2m2m -b:v 2M -pix_fmt yuv420p -c:a libfdk_aac  -b:a 96k -f mp4 /media/moon/convert/"${file%.mp4}.mp4"; done 


for file in "$1"; do ffmpeg -hwaccel cuda  -hwaccel_output_format nv12  -i "$file"  -c:v hevc_nvenc -preset slow  -bufsize 5M   -c:a libfdk_aac  -b:a 96k  -f mp4 "${file%.*}_1.mp4"; done

# DVD 

#ffmpeg -hwaccel cuda  -hwaccel_output_format nv12  -i outout.vob -map 0:0   -c:v h264_nvenc -preset hq -b:v 3M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1    -c:a libfdk_aac  -b:a 128k  -map 0:4  -f mp4 test.mp4

#-map 0:a -map 0:m:language:eng -map 0:v

#  metadata
#ffmpeg -hwaccel cuda  -hwaccel_output_format nv12  -i /home/spook/ouput.img  -metadata title='only lover left alive'     -map 0:1   -c:v h264_nvenc -preset slow -minrate 3M -bufsize 5M -maxrate 7M -qmin 0  -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1  -c:a libfdk_aac  -map 0:7  -b:a 128k  -f mp4 only.mp4



#find . -name *.avi -or -name *.mkv -or -name *.mp4 -or -name *flv -exec ffmpeg -hwaccel drm -i {}  -c:v h264_v4l2m2m -b:v 1500k -pix_fmt yuv420p  -trellis 2 -cmp 2 -subcmp 2  -g 60  -c:a libfdk_aac  -b:a 96k -f mp4 {}_1.mp4 \;

##    ffmpeg -y -vsync 0 -hwaccel cuda -hwaccel_output_format nv12 -i  -c:a copy -c:v h264_nvenc -preset p6 -tune ll -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 output.mp4
##low-latency  
# ffmpeg -y -vsync 0 -hwaccel cuda -hwaccel_output_format cuda -i "$file"  -c:a libfdk_aac  -b:a 128k  -c:v h264_nvenc -preset hq  -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 output.mp4
