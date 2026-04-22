
cuda nvenc nvdec usw for ffmpeg for debian trixie
   sudo apt install libfdk* nvidia-cuda-toolkit nvidia-driver nvidia-kernel-dkms build-essential yasm cmake libtool libc6 libc6-dev unzip wget libnuma1 libnuma-dev ffmpeg mpv

   sudo apt-build-dep ffmpeg mpv
   
   sudo apt purge  ocl-icd-libopencl1 ocl-icd-opencl-dev 
dkms.conf
   sudo nano /usr/src/nvidia-current-550.163.01/dkms.conf 
change to
    # DKMS configuration for the NVIDIA kernel module.  -*- sh -*-

    PACKAGE_NAME="nvidia-current"
    PACKAGE_VERSION="550.163.01"

     # Only kernels from 3.10 onwards are supported.
    #BUILD_EXCLUSIVE_KERNEL="^(3\.[1-9][0-9]|[4-9]\.)"

     # The NVIDIA driver does not support real-time kernels.
     #BUILD_EXCLUSIVE_CONFIG=""
     #BUILD_EXCLUSIVE_CONFIG="!CONFIG_PREEMPT_RT !CONFIG_PREEMPT_RT_FULL"


     AUTOINSTALL=yes

     MAKE[0]="env NV_VERBOSE=1 \
      make ${parallel_jobs+-j$parallel_jobs} modules KERNEL_UNAME=${kernelver} IGNORE_XEN_PRESENCE=1 IGNORE_CC_MISMATCH=1 "
     CLEAN="true"

     BUILT_MODULE_NAME[0]="nvidia"
     DEST_MODULE_NAME[0]="$PACKAGE_NAME"
     DEST_MODULE_LOCATION[0]="/updates/dkms"

     BUILT_MODULE_NAME[1]="nvidia-modeset"
     DEST_MODULE_NAME[1]="$PACKAGE_NAME-modeset"
     DEST_MODULE_LOCATION[1]="/updates/dkms"

     BUILT_MODULE_NAME[2]="nvidia-drm"
     DEST_MODULE_NAME[2]="$PACKAGE_NAME-drm"
     DEST_MODULE_LOCATION[2]="/updates/dkms"

     BUILT_MODULE_NAME[3]="nvidia-uvm"
     DEST_MODULE_NAME[3]="$PACKAGE_NAME-uvm"
     DEST_MODULE_LOCATION[3]="/updates/dkms"

     BUILT_MODULE_NAME[4]="nvidia-peermem"
     DEST_MODULE_NAME[4]="$PACKAGE_NAME-peermem"
     DEST_MODULE_LOCATION[4]="/updates/dkms"
install rt kernel
  sudo IGNORE_XEN_PRESENCE=1 IGNORE_CC_MISMATCH=1 IGNORE_PREEMPT_RT_PRESENCE=1 apt install linux-image-rt-amd64 linux-headers-rt-amd64


     apt source ffmpeg

     cd ffmpeg?????
