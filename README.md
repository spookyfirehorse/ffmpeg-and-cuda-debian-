build cuda nvenc nvdec usw for ffmpeg
       
       sudo nano /etc/apt/sources.list.d/cuda-debian12-x86_64.list
       deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ / 
       sudo apt install cuda
       sudo apt install libfdk*
       
       apt source ffmpeg mpv 
       
       PATH=/usr/local/cuda/bin:${PATH}  ./configure --prefix=/usr --extra-version=3 --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libdav1d --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libglslang --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librabbitmq --enable-librist --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt --enable-libssh --enable-libsvtav1 --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzimg --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --disable-sndio --enable-libjxl --enable-pocketsphinx --enable-librsvg --enable-libvpl --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-libplacebo --enable-librav1e --enable-shared --disable-static --enable-nonfree --enable-cuda --enable-cuda-llvm --enable-vaapi --enable-nvdec --enable-cuvid --enable-nvenc --enable-ffnvcodec --extra-cflags=-I/usr/local/cuda/include/ --enable-libfdk-aac --enable-libwebp --enable-libaribb24 --enable-libopencore_amrnb --enable-libopencore_amrwb --enable-libtesseract --enable-libvo_amrwbenc --enable-version3 --enable-cuda-nvcc --enable-libnpp --extra-ldflags=-L/usr/local/cuda/lib64 && make -j4 &&  sudo make -j 4 install



      




nvenc + fdkaac +x11grab

you need the sound card alsa output 

you getting by 

              pactl list | grep -A2 'Source #' | grep 'Name: '

make a scipt
       
       ffmpeg  -hide_banner  -hwaccel nvdec -hwaccel_output_format nv12 \
         -f pulse -ac 2 -i alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.pro-output-0.monitor  \
         -f x11grab -r 30  -video_size 1920x1080 -i :0.0+0,0 -c:v h264_nvenc  \
          -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -fpsmax 25 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 \
         -c:a libfdk_aac -profile:a aac_he -b:a 64k  -ar 48000   -f rtsp rtsp://localhost:8559/mystream

nvenc + opus + x11grab

       ffmpeg +genpts+igndts+nobuffer   -hide_banner  -hwaccel nvdec -hwaccel_output_format nv12  \
         -f pulse -ac 2 -i alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.pro-output-0.monitor  \
         -f x11grab -r 30  -video_size 1920x1080 -i :0.0+0,0 -c:v h264_nvenc  \
          -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 -fpsmax 25 \
         -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000   -f rtsp rtsp://localhost:8559/mystream

nvenc + fdkaac +stream input +stream output

       ffmpeg  -re  -fflags -vsync 0   -hwaccel nvdec -hwaccel_output_format nv12  -i  https://stv-live.akamaized.net/hls/live/2031011/lingeoSTVATwebPri/master_6692.m3u8  -hide_banner    \
         -vcodec h264_nvenc -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75    -fpsmax 25    -b_qfactor 1.1 -c:a libfdk_aac -profile:a aac_he -b:a 64k  -threads 4  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream

nvenc + opus stream input

         ffmpeg  -re  -vsync 0  -hwaccel nvdec -hwaccel_output_format nv12  -i  https://stv-live.akamaized.net/hls/live/2031011/lingeoSTVATwebPri/master_6692.m3u8  -hide_banner    \
         -vcodec h264_nvenc -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75   -fpsmax 25     -b_qfactor 1.1 -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000 -threads 4  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream

all to mkv aac
       
           for file in "$1"; do ffmpeg -vsync 0  -hwaccel cuda -hwaccel_output_format nv12   -i "$file"  -c:v h264_nvenc    -preset p6 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1      -c:a libfdk_aac  -b:a 96k -f matroska "${file%.*}_high.mkv"; done

opus

              for file in "$1"; do ffmpeg -vsync 0  -hwaccel cuda -hwaccel_output_format nv12   -i "$file"  -c:v h264_nvenc    -preset p6 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1  -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000 -f matroska "${file%.*}_high.mkv"; done

dvd + all subtitles and all audio


 
Ripping full dvd with all subtitle and all languages

by hand if you want special tracks or longest


       
       sudo mount /dev/sr0 /dev/dvd
       lsdvd /dev/sr0 ### look for longest track on the end of output
       mplayer dvd://3  -dvd-device  output.iso  -dumpstream -dumpfile output.vob
       mplayer dvd://3 -dumpstream -dumpfile output.vob ## now you have the dumpstream for the next step to create a mp4 or inthis case mkv
       mpv dvd://2 --stream-dump=output.vob #mpv count -1 lsdvd
       vobcopy -t example  -i /dev/sr0 -l  -n 3 -o /media/spooky/storage/



or simply


       mpv dvdnav:// --cache=no --dvd-device=/media/spooky/store/down-by-low.img --stream-dump=output.vob


now you heave the vob file

now you neeed the .IFO file for your movie for the subtitle

so you heave to copy the file in your home directory named default.IFO

               ls -lah dvd/VIDEO_TS/

-r--r--r-- 1 nobody nogroup  44K  7. Feb 2036  VTS_07_0.IFO

-r--r--r-- 1 nobody nogroup 9,7M  7. Feb 2036  VTS_07_0.VOB

-r--r--r-- 1 nobody nogroup 1,0G  7. Feb 2036  VTS_07_1.VOB

-r--r--r-- 1 nobody nogroup 1,0G  7. Feb 2036  VTS_07_2.VOB

-r--r--r-- 1 nobody nogroup 1,0G  7. Feb 2036  VTS_07_3.VOB

-r--r--r-- 1 nobody nogroup 1,0G  7. Feb 2036  VTS_07_4.VOB

 -r--r--r-- 1 nobody nogroup 1,0G  7. Feb 2036  VTS_07_5.VOB
 
 -r--r--r-- 1 nobody nogroup 251M  7. Feb 2036  VTS_07_6.VOB


and looking for 1 gb files


the IFO file before is the right one 



in this case


       sudo cp /dev/dvd/VTS_07_0.IFO default.IFO  


so now the finsh

       nano example.sh

copy and past in     

        #!/bin/bash
       for file in "$1"; do   ffmpeg   -hwaccel cuda -probesize 1200M -analyzeduration 1210M   -hwaccel_output_format nv12 -ifo_palette default.IFO    \
        -canvas_size 720x576  -i "$file"  -ss 00:00:02     -metadata title="$file"  -map 0:v -scodec dvdsub  \
         -map 0:s     -c:v hevc_nvenc -profile:v main10  -level 5.2 -preset p5 -tune hq -b:v 3M -maxrate 5M   -qmin 0 -g 250 -rc-lookahead 20 -aspect 16:9   \
         -c:a libfdk_aac  -b:a 128k  -map 0:a  -f matroska  "${file%.*}.mkv"; done

maybe you heave to set cnvas size to your movie resolution in the script -canvas_size 720x576 to correct the right place

              sudo cp ripping-dvd.sh /usr/local/bin/

and run

       ripping-dvd.sh output.vob

play it

         mpv output.mkv

       
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
