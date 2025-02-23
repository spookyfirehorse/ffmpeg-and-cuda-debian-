sudo apt install php-all-dev sndfile-tools libsndfile1-dev && cd ~/ffmpeg_sources/  && \ 
cd ~/ffmpeg_sources && wget http://deb.debian.org/debian/pool/main/l/lsp-plugins/lsp-plugins_1.2.20.orig.tar.gz &&\
tar -xf lsp-plugins_1.2.20.orig.tar.gz && cd lsp-plugins-1.2.20 && ./build-armv7a.sh && make -j4 && sudo make -j4 install
