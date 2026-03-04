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



###################################################################################################################


#!/bin/bash

# Ziel setzen (Argument oder aktuelles Verzeichnis)
TARGET="${1:-.}"

process_file() {
    local file="$1"
    local output="${file%.*}_high.mkv"
    local temp="temp_repair_$$.mkv"

    echo "========================================"
    echo "VERARBEITE: $file"
    echo "========================================"

    # 1. SCHRITT: Software-Fix (Packed B-Frames & Interleaving)
    if ! ffmpeg -y -i "$file" -c copy -bsf:v mpeg4_unpack_bframes "$temp" -loglevel error; then
        echo "!!! FEHLER beim Reparieren von $file - überspringe !!!"
        rm -f "$temp"
        return 1
    fi

    # 2. SCHRITT: High-Quality NVENC Encoding
    ffmpeg -hwaccel cuda -hwaccel_output_format nv12 -i "$temp" \
      -metadata title="$file" \
      -map 0:v? -map 0:a? -map 0:s? \
      -c:v h264_nvenc -preset p6 -tune hq -b:v 5M -bufsize 5M -maxrate 10M \
      -qmin 0 -g 250 -bf 3 -b_ref_mode middle -temporal-aq 1 -rc-lookahead 20 \
      -i_qfactor 0.75 -b_qfactor 1.1 \
      -c:a libfdk_aac -b:a 128k -af "volume=1.5" \
      -scodec copy -f matroska "$output" -y

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
    # Findet .avi und .AVI im aktuellen Ordner
    find "$TARGET" -maxdepth 1 -type f \( -iname "*.avi" \) | while read -r f; do
        process_file "$f"
    done
fi

echo "========================================"
echo "ALLE AUFGABEN ERLEDIGT! - GPU ist fertig."
echo -e "\a"



