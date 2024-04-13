 # cuda nvenc nvdec usw for ffmpeg for debian trixie
       
       
       sudo apt-get install build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev
       sudo apt build-dep ffmpeg
       sudo apt purge  ocl-icd-libopencl1 ocl-icd-opencl-dev
       sudo apt install nvidia-cuda-toolkit nvidia-driver
       sudo apt install libfdk* 
       
# ffmpeg for debian trixie testing

         git clone -b release/6.1 https://github.com/FFmpeg/FFmpeg.git && cd FFmpeg
         
         ./configure --prefix=/usr/ --extra-version=3 --toolchain=hardened  \
         --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 \
         --enable-gpl --disable-stripping --enable-gnutls --enable-ladspa --enable-libaom  \
         --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio \
         --enable-libcodec2 --enable-libdav1d --enable-libflite --enable-libfontconfig \
         --enable-libfreetype --enable-libfribidi --enable-libglslang --enable-libgme --enable-libgsm \
         --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt \
         --enable-libopus --enable-libpulse --enable-librabbitmq --enable-librist --enable-librubberband \
         --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt --enable-libssh \
         --enable-libsvtav1 --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis \
         --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid \
         --enable-libzimg --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal \
         --enable-opengl --enable-sdl2 --disable-sndio --enable-libjxl --enable-pocketsphinx \
         --enable-librsvg --enable-libvpl --enable-libdc1394 --enable-libdrm --enable-libiec61883 \
         --enable-chromaprint --enable-frei0r --enable-libx264 --enable-libplacebo --enable-librav1e \
         --enable-shared --disable-static --enable-nonfree --enable-cuda --enable-cuda-llvm --enable-vaapi \
         --enable-nvdec --enable-cuvid --enable-nvenc --enable-ffnvcodec  --enable-libfdk-aac --enable-libwebp \
         --enable-libaribb24 --enable-libopencore_amrnb --enable-libopencore_amrwb --enable-libtesseract \
         --enable-libvo_amrwbenc --enable-version3 --enable-cuda-nvcc --enable-libnpp  && make -j4 &&  sudo make -j 4 install


# debiab bookworm 

     sudo apt autoremove cuda* nvidia* --purge
     curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub | sudo gpg --dearmor | sudo tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1


     echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /' | sudo tee /etc/apt/sources.list.d/nvidia-drivers.list

      apt show cuda-drivers -a
      sudo apt install nvidia-driver cuda-drivers-545 cuda
      sudo apt build-dep ffmpeg
      sudo apt purge  ocl-icd-libopencl1 ocl-icd-opencl-dev
      sudo apt-get install build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev

  


          apt source ffmpeg && cd ffmpeg-5.1.4 && export PATH=/usr/local/cuda/bin:${PATH} ./configure --prefix=/usr/ --extra-version=3 --toolchain=hardened --libdir=/usr/lib/x86_64-linux-gnu --incdir=/usr/include/x86_64-linux-gnu --arch=amd64 --enable-gpl --disable-stripping --enable-gnutls --enable-ladspa --enable-libaom --enable-libass --enable-libbluray --enable-libbs2b --enable-libcaca --enable-libcdio --enable-libcodec2 --enable-libdav1d --enable-libflite --enable-libfontconfig --enable-libfreetype --enable-libfribidi --enable-libglslang --enable-libgme --enable-libgsm --enable-libjack --enable-libmp3lame --enable-libmysofa --enable-libopenjpeg --enable-libopenmpt --enable-libopus --enable-libpulse --enable-librabbitmq --enable-librist --enable-librubberband --enable-libshine --enable-libsnappy --enable-libsoxr --enable-libspeex --enable-libsrt --enable-libssh --enable-libsvtav1 --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvorbis --enable-libvpx --enable-libwebp --enable-libx265 --enable-libxml2 --enable-libxvid --enable-libzimg --enable-libzmq --enable-libzvbi --enable-lv2 --enable-omx --enable-openal --enable-opengl --enable-sdl2 --disable-sndio --enable-libjxl --enable-pocketsphinx --enable-librsvg --enable-libdc1394 --enable-libdrm --enable-libiec61883 --enable-chromaprint --enable-frei0r --enable-libx264 --enable-libplacebo --enable-librav1e --enable-shared --disable-static --enable-nonfree --enable-cuda --enable-cuda-llvm --enable-vaapi --enable-nvdec --enable-cuvid --enable-nvenc --enable-ffnvcodec --enable-libfdk-aac --enable-libwebp --enable-libaribb24 --enable-libopencore_amrnb --enable-libopencore_amrwb --enable-libtesseract --enable-libvo_amrwbenc --enable-version3 --enable-cuda-nvcc --enable-libnpp --extra-cflags=-I/usr/local/cuda/include --extra-ldflags=-L/usr/local/cuda/lib64

        && make -j4 &&  sudo make -j 4 install

 #       look for your options

    ffmpeg -h encoder=h264_nvenc


 #         basic input output

     ffmpeg -vsync 0 -hwaccel nvdec   -c:v h264_nvenc -i input.mp4 -c:a copy  -b:v 5M output.mp4
   
more detail later

##        nvenc + fdkaac +x11grab

you need the sound card alsa output monitor

you getting by 

              pactl list | grep -A2 'Source #' | grep 'Name: '


#                                  BASIC RTSP STREAM

FPS and BITRATE depends on your upload speed

low-latency-streaming camera /dev/video0 plughw 0 first audio device micro

              
     ffmpeg +genpts+igndts+nobuffer   -hide_banner  -hwaccel nvdec -hwaccel_output_format nv12  \
         -f alsa -ac 2 -i plughw:0  \
         -i /dev/video0 -c:v h264_nvenc  \
          -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 -fpsmax 25 \
         -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000   -f rtsp rtsp://localhost:8559/mystream
   
   
   #  record to file   h264 matroska        

         ffmpeg +genpts+igndts+nobuffer   -hide_banner  -hwaccel nvdec -hwaccel_output_format nv12  \
         -f alsa -ac 2 -i plughw:0  \
         -i /dev/video0 -c:v h264_nvenc  \
          -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 -fpsmax 25 \
         -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000   -f matroska output.mkv

  
 


##   nvenc + opus + x11grab

       ffmpeg +genpts+igndts+nobuffer   -hide_banner  -hwaccel nvdec -hwaccel_output_format nv12  \
         -f pulse -ac 2 -i alsa_output.usb-Yamaha_Corporation_Steinberg_UR22C-00.pro-output-0.monitor  \
         -f x11grab -r 30  -video_size 1920x1080 -i :0.0+0,0 -c:v h264_nvenc  \
          -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1 -fpsmax 25 \
         -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000   -f rtsp rtsp://localhost:8559/mystream

###  nvenc + fdkaac +stream input +stream output

       ffmpeg  -re  -fflags +genpts+igndts+discardcorrupt+nobufferr -vsync 0   -hwaccel nvdec -hwaccel_output_format nv12  -i  https://stv-live.akamaized.net/hls/live/2031011/lingeoSTVATwebPri/master_6692.m3u8  -hide_banner    \
         -vcodec h264_nvenc -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75    -fpsmax 25    -b_qfactor 1.1 -c:a libfdk_aac -profile:a aac_he -b:a 64k  -threads 4  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream

##  nvenc + opus stream input

         ffmpeg  -re -fflags +genpts+igndts+discardcorrupt+nobuffer -vsync 0  -hwaccel nvdec -hwaccel_output_format nv12  -i  https://stv-live.akamaized.net/hls/live/2031011/lingeoSTVATwebPri/master_6692.m3u8  -hide_banner    \
         -vcodec h264_nvenc -bufsize 8M -filter:v scale=720:-1 -b:v 1M  -preset p2 -tune ll  -profile:v  main  -level:v 4.1 -maxrate 2M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75   -fpsmax 25     -b_qfactor 1.1 -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000 -threads 4  -f rtsp -rtsp_transport tcp  rtsp://localhost:8559/mystream

all to mkv aac
       
           for file in "$1"; do ffmpeg -fflags +genpts+igndts+discardcorrupt+nobuffer -vsync 0  -hwaccel cuda -hwaccel_output_format nv12   -i "$file"  -c:v h264_nvenc  -profile:v high -level 4.2   -preset p6 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1      -c:a libfdk_aac  -b:a 96k -f matroska "${file%.*}_high.mkv"; done

##  opus

              for file in "$1"; do ffmpeg -fflags +genpts+igndts+discardcorrupt+nobuffer -vsync 0  -hwaccel cuda -hwaccel_output_format nv12   -i "$file"  -c:v h264_nvenc   -profile:v high -level 4.2 -preset p6 -tune hq -b:v 3M -bufsize 5M -maxrate 5M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1  -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000 -f matroska "${file%.*}_high.mkv"; done

dvd + all subtitles and all audio


 
#####                            Ripping full dvd with all subtitle and all languages




      
       lsdvd /dev/sr0 ### look for longest track on the end of output

        lsdvd -v /dev/sr0   ##for resolution

         lsdvd -p /dev/sr0   ##for colorpalette
        
       mplayer dvd://3 -nocache -dvd-device  /dev/sr0  -dumpstream -dumpfile output.vob

       mplayer dvd://3 -nocache -dvd-device  output.iso  -dumpstream -dumpfile output.vob

   ## 
      mpv dvd://2 --dvd-device=/dev/sr0 --cache=no  --stream-dump=output.vob 
      
      mpv dvdnav:// --cache=no --dvd-device=/dev/sr0 --stream-dump=output.vob

       
per chapter 

       mplayer dvd://8  -dvd-device /dev/sr0  -chapter 2-14  -dumpstream -dumpfile ~/3.VOB

       
       vobcopy -t example  /dev/sr0 -l  -n 2 -o ~
       
       dvdbackup -i  /dev/sr0 -n examplename  -t 2 -p  -o /home/spooky/
       
       mencoder dvd://2 -nocache -dvd-device  /media/storage/output.iso -o /dev/null | grep aid 
       mencoder dvd://2 -nocache -dvd-device  /media/storage/output.iso -o /dev/null | grep sid 
       
 verbose
 
       sudo lsdvd -t 3 -x  /dev/sr0

or simply from iso 

    mpv dvd://2 --cache=no   --dvd-device=/dev/sr0  --stream-dump=output.vob




or simply dvd for the primary movie


       mpv dvdnav:// --cache=no --dvd-device=/dev/sr0 --stream-dump=output.vob

       
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

#   transcode all  video + audi0 + subtitle  

#  hevc matroska

       #!/bin/bash
          for file in "$1"; do   ffmpeg -fix_sub_duration -fflags +genpts  -hwaccel nvenc -hwaccel_output_format nv12 -probesize 4200M -analyzeduration 42100M  -ifo_palette default.IFO  \
        -canvas_size  720x576   -i "$file"  -ss 00:00:02     -metadata title='"$file"'  -map 0:v -scodec dvbsub   -map 0:s   \
        -c:v hevc_nvenc -profile:v main10 -pix_fmt p010le -level 4.0 -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250  -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1    \
        -c:a libfdk_aac  -b:a 128k -map 0:a -af volume=1.5   -f matroska  "${file%.*}_1.mkv"; done

     
      ffmpeg -fix_sub_duration -fflags +genpts  -hwaccel nvenc -hwaccel_output_format nv12 -probesize 4200M -analyzeduration 42100M  -ifo_palette default.IFO  \
      -canvas_size  720x576   -i "$file"  -ss 00:00:02     -metadata title='"$file"'  -map 0:v -scodec dvbsub   -map 0:s   \
       -c:v hevc_nvenc -profile:v main10 -pix_fmt p010le -level 4.0 -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250  -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1    \
      -c:a libfdk_aac  -b:a 128k -map 0:a -af volume=1.5   -f matroska  "output.mkv


         
# h264 mkv

               #!/bin/bash
       for file in "$1"; do   ffmpeg  -fflags +genpts -fix_sub_duration -hwaccel cuda -probesize 1200M -analyzeduration 1210M   -hwaccel_output_format nv12 -ifo_palette default.IFO    \
        -canvas_size 720x576  -i "$file"  -ss 00:00:02     -metadata title="$file"  -map 0:v -scodec dvdsub  \
         -map 0:s     -c:v h264_nvenc -profile:v high  -level 4.2 -preset p5 -tune hq -b:v 3M -maxrate 5M   -qmin 0 -g 250 -rc-lookahead 20     \
         -c:a libfdk_aac  -b:a 128k  -map 0:a  -f matroska  "${file%.*}.mkv"; done

          
       ffmpeg  -fflags +genpts  -fix_sub_duration -hwaccel cuda -probesize 1200M -analyzeduration 1210M   -hwaccel_output_format nv12 -ifo_palette default.IFO    \
        -canvas_size 720x576  -i "$file"  -ss 00:00:02     -metadata title="$file"  -map 0:v -scodec dvdsub  \
         -map 0:s     -c:v h264_nvenc -profile:v high  -level 4.2 -preset p5 -tune hq -b:v 3M -maxrate 5M   -qmin 0 -g 250 -rc-lookahead 20     \
         -c:a libfdk_aac  -b:a 128k  -map 0:a  -f matroska  output.mkv


#  h264 mp4

        #!/bin/bash
       for file in "$1"; do   ffmpeg  -fflags +genpts  -fix_sub_duration -hwaccel cuda -probesize 1200M -analyzeduration 1210M   -hwaccel_output_format nv12 -ifo_palette default.IFO    \
        -canvas_size 720x576  -i "$file"  -ss 00:00:02     -metadata title="$file"  -map 0:v -scodec dvdsub  \
         -map 0:s     -c:v h264_nvenc -profile:v high  -level 4.2 h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1    \
         -c:a libfdk_aac  -b:a 128k  -map 0:a  -f mp4  "${file%.*}.mp4"; done


        
       ffmpeg  -fflags +genpts  -fix_sub_duration -hwaccel cuda -probesize 1200M -analyzeduration 1210M   -hwaccel_output_format nv12 -ifo_palette default.IFO    \
        -canvas_size 720x576  -i "$file"  -ss 00:00:02     -metadata title="$file"  -map 0:v -scodec dvdsub  \
         -map 0:s     -c:v h264_nvenc -profile:v high  -level 4.2 h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1    \
         -c:a libfdk_aac  -b:a 128k  -map 0:a  -f mp4  output.mp4

#  h264 matroska mkv

        #!/bin/bash
       for file in "$1"; do   ffmpeg  -fflags +genpts  -fix_sub_duration -hwaccel cuda -probesize 1200M -analyzeduration 1210M   -hwaccel_output_format nv12 -ifo_palette default.IFO    \
        -canvas_size 720x576  -i "$file"  -ss 00:00:02     -metadata title="$file"  -map 0:v -scodec dvdsub  \
         -map 0:s     -c:v h264_nvenc -profile:v high  -level 4.2 h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1    \
         -c:a libfdk_aac  -b:a 128k  -map 0:a  -f matroska  "${file%.*}.mp4"; done


        
       ffmpeg  -fflags +genpts  -fix_sub_duration -hwaccel cuda -probesize 1200M -analyzeduration 1210M   -hwaccel_output_format nv12 -ifo_palette output.IFO    \
        -canvas_size 720x576  -i output.vob  -metadata title="example"  -map 0:v -scodec dvdsub  \
         -map 0:s     -c:v h264_nvenc -profile:v high  -level 4.2 h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1    \
         -c:a libfdk_aac  -b:a 128k  -map 0:a  -f matroska  output.mkv



# for corrupted files


# separate subtitle only

              ffmpeg  -probesize 1400M -analyzeduration 1410M  -fflags +genpts+igndts+discardcorrupt -ifo_palette default.IFO -fix_sub_duration     -i only_lovers_left_alive2.vob   -vn -an    -scodec copy   -map 0:s   -vn  -f matroska    test.mkv
         

# separate audio and specific  subtitles for corrupt files


       ffmpeg  -probesize 1400M -analyzeduration 1410M  -fflags +genpts+igndts+discardcorrupt -ifo_palette default.IFO -fix_sub_duration -canvas_size  720x576    -i only_lovers_left_alive2.vob   -c:a libfdk_aac -b:a 128k    -map 0:a -scodec dvdsub -map 0:s   -vn  -f matroska    testa.mkv

# separate audio and all subtitles for corrupt files


        ffmpeg  -probesize 1400M -analyzeduration 1410M -fflags +genpts+igndts+discardcorrupt -ifo_palette default.IFO -fix_sub_duration -canvas_size  720x576    -i only_lovers_left_alive2.vob   -c:a libfdk_aac -b:a 128k    -map 0:a -scodec dvdsub    -map 0:s -vn  -f matroska    test.mkv

# seperate video

         ffmpeg -y   -fflags +genpts+igndts+discardcorrupt    -hwaccel cuda  -probesize 1400M -analyzeduration 1410M   -hwaccel_output_format nv12  -i testv.mpeg   -c:v h264_nvenc -profile:v high  -level 4.2 -preset p5 -tune hq   -b:v 3M -bufsize 5M -maxrate 4M -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 -i_qfactor 0.75 -b_qfactor 1.1  -aspect 16:9 -sn -an    -f matroska  testv.mkv

# muxing together

         ffmpeg -fflags +genpts -i testv.mkv  -i testa.mkv  -c:v copy -c:a copy -c:s copy  -map 0:v -map 1:a    -map 1:s  -f matroska output.mkv


# maybe you heave to set cnvas size to your movie resolution ( original ) in the script -canvas_size 720x576 to correct the right place

              sudo cp ripping-dvd.sh /usr/local/bin/

and run

       ripping-dvd.sh output.vob

play it

         mpv output.mkv

       
android

       ffmpeg -fflags +genpts+igndts+discardcorrupt  -hwaccel cuda -hwaccel_output_format nv12   -fflags +genpts+nobuffer+discardcorrupt   -hide_banner -rtsp_transport tcp   -i rtsp://127.0.0.1:8080/h264_pcm.sdp -c:v h264_nvenc -b:v 1M  -preset p1 -tune ll       -c:a libopus  -b:a 64k  -application lowdelay  -ar 48000  -f rtsp -rtsp_transport tcp  rtsp://localhost:8554/mystream


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
