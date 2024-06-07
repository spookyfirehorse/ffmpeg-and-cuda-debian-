git clone https://github.com/HandBrake/HandBrake.git && cd HandBrake

./configure --enable-gtk --enable-fdk-aac --enable-nvenc --enable-nvdec    --launch-jobs=$(nproc) --launch

sudo make --directory=build uninstall
