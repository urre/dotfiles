#!/usr/bin/env zsh

# Fix video/audio sync lag by offsetting the audio track
# Arguments:
#   $1 - delay in seconds (e.g., -0.2 for 200ms earlier, 0.2 for 200ms later)
#   $2 - input file (e.g., input.mp4)
# Output: Creates a new file with "_fixed" suffix (e.g., input_fixed.mp4)
function fixlag() {
  local delay="$1"
  local input_file="$2"

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

# Convert an MP4 video to a GIF
# Arguments:
#   $1 - input file (e.g., input.mp4)
#   $2 - output file (optional, defaults to input.gif)
#   $3 - fps (optional, defaults to 15)
#   $4 - width (optional, defaults to 720)
function mp4togif() {
  local input_file="$1"
  local base="${input_file%.*}"
  local output_file="${2:-${base}.gif}"
  local fps="${3:-15}"
  local width="${4:-720}"

  clear

  echo "Creating: $output_file"
  ffmpeg -i "$input_file" -vf "fps=${fps},scale=${width}:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "$output_file"

  if [ $? -eq 0 ]; then
    echo "✓ Successfully created $output_file"
  fi
}
