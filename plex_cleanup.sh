#!/bin/bash

###############################################################################
# Plex Cleanup Script for macOS (High Sierra compatible)
# -------------------------------------------------------
# This script:
# 1. Recursively scans the current directory and all subdirectories.
# 2. Deletes video files that are not supported by Plex.
# 3. Deletes folders that contain no supported Plex video files.
# 4. Shows every deleted file and folder.
# 5. Calculates and displays the total freed space (in MB).
#
# Supported formats (kept): mp4, mkv, avi, mov, mpg, mpeg, m4v
# Unsupported formats (removed): flv, vob, rm, rmvb, ts, divx, m2ts, mts, iso, img, bin, asf, 3gp, wmv
###############################################################################

# Supported video file extensions
VALID_EXTENSIONS=("mp4" "mkv" "avi" "mov" "mpg" "mpeg" "m4v")

echo "🔍 Starting Plex cleanup in: $(pwd)"
echo

# Initialize freed space counter (in bytes)
freed_space=0

#############################################
# Step 1: Find and delete unsupported videos
#############################################
echo "📁 Searching for unsupported video files..."
find . -type f \( -iname "*.flv" -o -iname "*.vob" -o -iname "*.rm" -o -iname "*.rmvb" -o -iname "*.ts" -o -iname "*.divx" -o -iname "*.m2ts" -o -iname "*.mts" -o -iname "*.iso" -o -iname "*.img" -o -iname "*.bin" -o -iname "*.asf" -o -iname "*.3gp" -o -iname "*.wmv" \) | while read -r file; do
  # Get file size in bytes before deletion
  size=$(stat -f%z "$file" 2>/dev/null)
  # Accumulate total freed space
  freed_space=$((freed_space + size))
  echo "🗑️  Deleting unsupported file: $file"
  rm -f "$file"
done

###################################################
# Step 2: Delete folders with no supported videos
###################################################
echo
echo "📁 Checking folders for deletion..."

find . -type d | while read -r dir; do
  has_valid_file=false

  # Check if directory contains any supported video file
  for ext in "${VALID_EXTENSIONS[@]}"; do
    if find "$dir" -maxdepth 1 -type f -iname "*.${ext}" | grep -q .; then
      has_valid_file=true
      break
    fi
  done

  if [ "$has_valid_file" = false ]; then
    # If the folder is empty (ignoring hidden files/folders), delete it
    if [ -z "$(find "$dir" -mindepth 1 -maxdepth 1 ! -name ".*" ! -type d)" ]; then
      echo "📦 Deleting empty folder: $dir"
      rmdir "$dir" 2>/dev/null
    fi
  fi
done

#########################
# Step 3: Show result
#########################
echo
freed_mb=$(echo "scale=2; $freed_space / 1048576" | bc)
echo "✅ Plex cleanup finished. Freed space: ${freed_mb} MB"
