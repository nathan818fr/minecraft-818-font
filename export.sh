#!/bin/bash
set -Eeuo pipefail
shopt -s inherit_errexit

function export_resourcepack() {
  local scale tmpdir
  scale="$1"
  tmpdir="$(mktemp -d)"

  # Prepare content
  cat './src/pack.mcmeta' | sed "s/%%SCALE%%/${scale}/g" | sed "s/%%VERSION%%/${version}/g" >"${tmpdir}/pack.mcmeta"
  convert -font Consolas -fill white -pointsize 60 -gravity SouthEast -draw "text 0,-10 '${scale}'" \
    './src/pack.png' "${tmpdir}/pack.png"
  mkdir -p "${tmpdir}/assets/minecraft/textures/font"
  cp './src/ascii.properties' "${tmpdir}/assets/minecraft/textures/font/ascii.properties"
  cp "./bitmap/ascii_${scale}.png" "${tmpdir}/assets/minecraft/textures/font/ascii.png"

  # Create zip
  zipfile="$(realpath -m "./out/818_HD_Font_${scale}.zip")"
  rm -f "$zipfile"
  mkdir -p "$(dirname "$zipfile")"
  (cd "$tmpdir" && zip -r "$zipfile" ./*)
}

function main() {
  version="0.1"
  for scale in x{1..8}; do
    export_resourcepack "$scale"
  done
}

main "$@"
exit 0
