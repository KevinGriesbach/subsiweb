#!/usr/bin/env bash
# Creates web-friendly copies in images/ — originals are left untouched.
#
# Usage: ./scripts/optimize-images.sh
#
# Requires: ImageMagick (brew install imagemagick)

set -euo pipefail
cd "$(dirname "$0")/.."

OUT="images"
MAX_SIZE="1920x1920>"   # shrink only if larger; longest edge ≤ 1920 px
QUALITY=82                # 75–85 is a good range for photos

mkdir -p "$OUT"

echo "Optimizing photos → $OUT/ (max ${MAX_SIZE%>} px, quality $QUALITY)…"
for src in pet-*.JPG wildlife-*.JPG; do
  [ -f "$src" ] || continue
  dest="$OUT/$src"
  echo "  $src"
  magick "$src" -strip -resize "$MAX_SIZE" -quality "$QUALITY" "$dest"
done

echo "Optimizing logo → $OUT/logo.png (256 px wide)…"
magick logo.png -strip -resize '256x256>' "$OUT/logo.png"

echo ""
echo "Done. Sizes:"
ls -lh "$OUT"
