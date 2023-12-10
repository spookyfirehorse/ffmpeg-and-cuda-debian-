       sudo apt build-dep ffmpeg mpv
       
       apt source ffmpeg mpv 
       
       export PATH=/usr/local/cuda/bin:${PATH}  ./configure --prefix=/usr --extra-version=3 --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libdav1d --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libglslang --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librabbitmq --enable-librist --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt --enable-libssh --enable-libsvtav1 --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzimg --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --disable-sndio --enable-libjxl --enable-pocketsphinx --enable-librsvg --enable-libvpl --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-libplacebo --enable-librav1e --enable-shared --disable-static --enable-nonfree --enable-cuda --enable-cuda-llvm --enable-vaapi --enable-nvdec --enable-cuvid --enable-nvenc --enable-ffnvcodec --extra-cflags=-I/usr/local/cuda/include/ --enable-libfdk-aac --enable-libwebp --enable-libaribb24 --enable-libopencore_amrnb --enable-libopencore_amrwb --enable-libtesseract --enable-libvo_amrwbenc --enable-version3 --enable-cuda-nvcc --enable-libnpp &&make -j4 &&  sudo make -j 4 install



      




nvenc + fdkaac +x11grab
       
       ffmpeg -async 1 -hide_banner  -hwaccel nvdec -hwaccel_output_format nv12 \
         -f pulse -ac 2 -i alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.pro-output-0.monitor  \
         -f x11grab -r 30  -video_size 1920x1080 -i :0.0+0,0 -c:v h264_nvenc  \
          -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 \
         -c:a libfdk_aac -profile:a aac_he -b:a 64k  -ar 48000   -f rtsp rtsp://localhost:8559/mystream

nvenc + opus + x11grab

       ffmpeg +genpts+igndts+nobuffer  -async 1 -hide_banner  -hwaccel nvdec -hwaccel_output_format nv12  \
         -f pulse -ac 2 -i alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.pro-output-0.monitor  \
         -f x11grab -r 30  -video_size 1920x1080 -i :0.0+0,0 -c:v h264_nvenc  \
          -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 \
         -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000   -f rtsp rtsp://localhost:8559/mystream

nvenc + fdkaac +stream input

       ffmpeg  -re  -fflags -vsync 0   -hwaccel nvdec -hwaccel_output_format nv12  -i  https://stv-live.akamaized.net/hls/live/2031011/lingeoSTVATwebPri/master_6692.m3u8  -hide_banner    \
         -vcodec h264_nvenc -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75        -b_qfactor 1.1 -c:a libfdk_aac -profile:a aac_he -b:a 64k  -threads 4  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream

nvenc + opus stream input

         ffmpeg  -re  -vsync 0   -hwaccel nvdec -hwaccel_output_format nv12  -i  https://stv-live.akamaized.net/hls/live/2031011/lingeoSTVATwebPri/master_6692.m3u8  -hide_banner    \
         -vcodec h264_nvenc -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75        -b_qfactor 1.1 -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000 -threads 4  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream

all to mkv aac
       
           for file in "$1"; do ffmpeg -vsync 0  -hwaccel cuda -hwaccel_output_format nv12   -i "$file"  -c:v h264_nvenc    -preset p6 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1      -c:a libfdk_aac  -b:a 96k -f matroska "${file%.*}_high.mkv"; done

opus

              for file in "$1"; do ffmpeg -vsync 0  -hwaccel cuda -hwaccel_output_format nv12   -i "$file"  -c:v h264_nvenc    -preset p6 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1  -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000 -f matroska "${file%.*}_high.mkv"; done

dvd + all subtitles and all audio


 lsdvd


       mplayer dvd://3 -dumpstream -dumpfile output.vob


       ffmpeg   -hwaccel cuda -probesize 12000M -analyzeduration 12100M   -hwaccel_output_format nv12 -vsync 0  -i  /home/spook/output.vob  -ss 00:00:02     -metadata title='MYSTERY TRAIN'  -map 0:v -scodec copy   -map 0:s          -c:v h264_nvenc -profile:v high -level 4.1 -preset p5 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1   -c:a libfdk_aac         -b:a 128k -map 0:a -f mp4  output.mp4





       ffmpeg   -hwaccel cuda  -probesize 12000M -analyzeduration 12100M   -hwaccel_output_format nv12 -vsync 0 -i  /media/moon/Filme/jim-jarmusch/ghost-dog.mkv  -ss 00:00:02  -metadata title='GHOST DOG'  -map 0:v -scodec copy   -map 0:s   -c:v h264_nvenc -preset p5 -tune hq  -profile:v high  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1   - bufsize 5M   -c:a libfdk_aac  -b:a 128k -map 0:a -f mp4  ghost-dog.mp4


android

       ffmpeg   -hwaccel cuda -hwaccel_output_format nv12   -fflags +genpts+nobuffer+discardcorrupt   -hide_banner -rtsp_transport tcp   -i rtsp://127.0.0.1:8080/h264_pcm.sdp -c:v h264_nvenc -b:v 1M  -preset p1 -tune ll       -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream


export

       export LD_LIBRARY_PATH=/home/john/cuda-7.5/lib64:$LD_LIBRARY_PATH
       export LIBRARY_PATH=/home/john/cuda-7.5/lib64:$LIBRARY_PATH
       export PATH=/home/john/cuda-7.5/bin:$PATH
       export CFLAGS=-I/home/me/local/include
       export LDFLAGS="-L/home/me/local/lib"
       export PKG_CONFIG_PATH=~/local/lib/pkgconfig
       LDFLAGS="-L/home/me/local/lib" CFLAGS="-I/home/me/local/include"
       export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/me/local/lib

     sudo firewall-cmd --permanent --add-port=8554/tcp
