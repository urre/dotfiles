#!/usr/bin/env zsh

# Fix video/audio sync lag by offsetting the audio track
# Arguments:
#   $1 - input file (e.g., input.mp4)
#   $2 - delay in seconds (e.g., -0.2 for 200ms earlier, 0.2 for 200ms later)
# Output: Creates a new file with "_fixed" suffix (e.g., input_fixed.mp4)
function fixlag() {
  local input_file="$1"
  local delay="$2"

  local base="${input_file%.*}"
  local ext="${input_file##*.}"
  local output_file="${base}_output.${ext}"

  clear

  echo "Creating: $output_file"
  ffmpeg -itsoffset "$delay" -i "$input_file" -i "$input_file" -map 1:v -map 0:a -c copy "$output_file"

  if [ $? -eq 0 ]; then
    echo "✓ Successfully created $output_file"
  fi
}
