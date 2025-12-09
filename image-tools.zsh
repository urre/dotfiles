# Merge all images in current folder side by side
# then open in CleanShot X (for fast annotations etc)
# Usage example: mergex
function mergex() {
  magick +append *.jpg merged.jpg;
  open -a CleanShot\ X/ merged.jpg
}

# Merge all images in current folder on top of each other
# then open in Preview or CleanShotX (for fast annotations etc)
# Usage example: mergey
function mergey() {
  magick -append *.jpg merged.jpg;
  # open -a Preview ~/desktop/merged.jpg
  open -a CleanShot\ X/ merged.jpg
}

# Scale image
scale() {
  if [ $# -ne 2 ]; then
    echo "Usage: scale image.jpg max_width"
    return 1
  fi

  local input_image="$1"
  local max_width="$2"
  local output_image="scaled_${input_image}"

  # Ensure 'magick' command is available
  if ! command -v magick >/dev/null 2>&1; then
    echo "Error: 'magick' (ImageMagick 7) not found in PATH."
    return 1
  fi

  # Resize image to max width, height auto-scaled
  magick "$input_image" -resize "${max_width}x" "$output_image"

  echo "Image scaled to max width ${max_width}px -> ${output_image}"
  open -a "CleanShot X" "$output_image"
}

# Collage of all images in the current folder
function montageall() {
  montage -background '#f2f2f2' -geometry 1680x -tile 3x1 -border 80 -bordercolor white *.jpg merged.jpg
  open -a Preview merged.jpg
}

# Annotate two images with "Before" and "After". Then merge two images side by side. Upload to Cloudinary if upload flag passed
# Usage example: amont 1.jpg 2.jpg upload
function amont() {

  # I store my screenshots on the desktop, so start here
  cd ~/desktop

  if [ "$4" = 'annotate' ]
  then
    # Annotate adding the Before/After text if annotate flag is passed
    convert "$1" -undercolor white -pointsize 66 -fill red  -gravity Northwest -annotate 0 'Before' "$1"
    convert "$2" -undercolor white -pointsize 66 -fill "#78BE21"  -gravity Northwest -annotate 0 'After' "$2"
  fi

  # Merge the two images side by side, open the image in Preview
  # montage -background '#f2f2f2' -geometry 1280x720+0+0 1.jpg 2.jpg merged.jpg;
  convert -background "#6e768f" 2.jpg +append \( 1.jpg \) -append -resize 1600x1600 result.jpg

  # Open in Preview
  open -a Preview ~/desktop/result.jpg

  # Upload to CDN if upload flag passed
  if [ "$3" = 'upload' ]
  then
    DIR=$( cd ~/.dotfiles && pwd )
    source "$DIR/.env"
    CLOUDINARY_URL=$(echo "$CLOUDINARY_URL")
    # Upload to Cloudinary and then copy the HTTPS image link to clipboard (using the cld uploader)
    cld uploader upload ~/desktop/result.jpg | jq -r '.secure_url' | pbcopy
  fi
}


# Convert mp4 to GIF with ffmpeg
# Usage: togif "validation.mp4" "output" 25 1.5
togif() {
  # Required arguments
  input_file="$1"
  output_file="$2"

  # Optional arguments with default values
  framerate="${3:-30}"
  pts="${4:-2}"

  ffmpeg -i "$input_file" -vf "setpts=PTS/$pts,fps=$framerate,scale=1520:-1:flags=lanczos" -c:v pam -f image2pipe - \
  | convert -delay 5 - -loop 0 -layers optimize "$output_file.gif"
}

# Extend images to 9x16 aspect ratio
extend_to_9x16() {
  local bg="${1:-#f2f2f2}"

  for f in *.png; do
    [[ -e "$f" ]] || { echo "No PNG files found."; return 1; }

    echo "Processing $f ..."
    magick "$f" \
      -gravity center \
      -background "$bg" \
      -extent "%[fx:ceil(max(w,9*h/16))]x%[fx:ceil(max(16*w/9,h))]" \
      "$f"
  done
}
