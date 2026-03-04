#!/bin/bash

# Ziel setzen (Argument oder aktuelles Verzeichnis)
TARGET="${1:-.}"

process_file() {
    local file="$1"
    local output="${file%.*}_high.mp4"
    local temp="temp_repair_$$.mkv"

    echo "========================================"
    echo "VERARBEITE: $file -> 720p MP4"
    echo "========================================"

    # 1. SCHRITT: Software-Fix (Muss sein, da NVENC bei kaputten AVI-Headern oft abbricht)
    if ! ffmpeg -y -i "$file" -c copy -bsf:v mpeg4_unpack_bframes "$temp" -loglevel error; then
        echo "!!! FEHLER beim Reparieren von $file - überspringe !!!"
        rm -f "$temp"
        return 1
    fi

    # 2. SCHRITT: High-Quality NVENC Encoding + Scaling
    # Nutzt CUDA Hardware-Decoding und Hardware-Scaling für maximale Speed
    ffmpeg -hwaccel cuda -hwaccel_output_format cuda -i "$temp" \
      -metadata title="$file" \
      -c:v h264_nvenc -profile:v high -level:v 4.1 \
      -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M \
      -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 \
      -i_qfactor 0.75 -b_qfactor 1.1 \
      -vf "scale_cuda=1280:-1" \
      -c:a libfdk_aac -b:a 96k \
      -movflags +faststart -f mp4 "$output" -y

    if [ $? -eq 0 ]; then
        echo ">>> ERFOLG: $output erstellt."
        rm "$temp"
    else
        echo "!!! NVENC FEHLER bei $file !!!"
        rm -f "$temp"
    fi
}

# Hauptschleife
if [ -f "$TARGET" ]; then
    process_file "$TARGET"
else
    find "$TARGET" -maxdepth 1 -type f \( -iname "*.avi" \) | while read -r f; do
        process_file "$f"
    done
fi

echo "========================================"
echo "ALLE AUFGABEN ERLEDIGT! - GPU hat fertig skaliert."
echo -e "\a"
