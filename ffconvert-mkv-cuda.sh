#!/bin/bash

for file in "$1"; do
  echo ">>> Prüfe & Repariere AVI-Struktur für NVENC: $file"
  
  # SCHRITT 1: Software-Fix (Packed B-Frames & Interleaving)
  # Erstellt einen sauberen Stream für die NVIDIA Karte
  ffmpeg -y -i "$file" -c copy -bsf:v mpeg4_unpack_bframes "temp_repair.mkv" -loglevel error

  if [ $? -eq 0 ]; then
    echo ">>> Starte High-Quality NVENC Encoding..."

    # SCHRITT 2: Dein High-Quality NVENC Setup
    ffmpeg -hwaccel cuda -hwaccel_output_format nv12 -i "temp_repair.mkv" \
      -c:v h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M \
      -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 \
      -i_qfactor 0.75 -b_qfactor 1.1 \
      -c:a libfdk_aac -b:a 96k \
      -f matroska "${file%.*}_high.mkv" -y

    rm "temp_repair.mkv"
    echo ">>> Fertig: ${file%.*}_high.mkv"
  else
    echo "!!! Reparatur fehlgeschlagen !!!"
  fi
done
