#!/bin/bash
meson setup build &&
meson configure build -Dffmpeg=enabled -Dalsa=enabled -Dprefix=/usr && 
meson compile -C build  &&
sudo meson install -C build 
