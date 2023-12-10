## for file in *.mp4; do ffmpeg -i "$file"  -vcodec copy -acodec copy Videos/"${file%.mp4}.mp4"; done
#
### for file in *.mp4; do ffmpeg -i "$file"  -vcodec copy -acodec copy "${file%.mp4}_1.mp4"; done



#for file in *.mp4; do ffmpeg -hwaccel drm -i "$file"  -c:v h264_v4l2m2m -b:v 2M -pix_fmt yuv420p -c:a libfdk_aac  -b:a 96k -f mp4 /media/moon/convert/"${file%.mp4}.mp4"; done

#for file in *.mp4; do ffmpeg -hwaccel drm -i "$file"  -c:v h264_v4l2m2m -b:v 2M -pix_fmt yuv420p -c:a libfdk_aac  -b:a 96k -f mp4 /media/moon/convert/"${file%.mp4}.mp4"; done 


for file in "$1"; do ffmpeg  -hwaccel cuda -hwaccel_output_format cuda   -i "$file"  -c:v h264_nvenc -profile:v high  -level:v 4.1   -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1   -filter:v scale=1280:-1    -c:a libfdk_aac  -b:a 96k -f mp4 "${file%.*}_high.mp4"; done



# -s 720x480

#find . -name *.avi -or -name *.mkv -or -name *.mp4 -or -name *flv -exec ffmpeg -hwaccel drm -i {}  -c:v h264_v4l2m2m -b:v 1500k -pix_fmt yuv420p  -trellis 2 -cmp 2 -subcmp 2  -g 60  -c:a libfdk_aac  -b:a 96k -f mp4 {}_1.mp4 \;

