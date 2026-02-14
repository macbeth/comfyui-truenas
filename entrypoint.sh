#!/usr/bin/env bash

# ComfyUI Docker Startup File by John Aldred
# http://www.johnaldred.com
# http://github.com/kaouthia

set -e

CN_DIR=/app/tags/v0.13.0/custom_nodes
INIT_MARKER="$CN_DIR/.custom_nodes_initialized"

declare -A REPOS=(
  ["ComfyUI-Manager"]="https://github.com/ltdrdata/ComfyUI-Manager.git"
  #["ComfyUI_essentials"]="https://github.com/cubiq/ComfyUI_essentials.git"
  #["ComfyUI-Crystools"]="https://github.com/crystian/ComfyUI-Crystools.git"
  #["rgthree-comfy"]="https://github.com/rgthree/rgthree-comfy.git"
  #["ComfyUI-KJNodes"]="https://github.com/kijai/ComfyUI-KJNodes.git"
  #["ComfyUI_UltimateSDUpscale"]="https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git"
)

if [ ! -f "$INIT_MARKER" ]; then
  echo "↳ First run: initializing custom_nodes…"
  mkdir -p "$CN_DIR"
  for name in "${!REPOS[@]}"; do
    url="${REPOS[$name]}"
    target="$CN_DIR/$name"
    if [ -d "$target" ]; then
      echo "  ↳ $name already exists, skipping clone"
    else
      echo "  ↳ Cloning $name"
      git clone --depth 1 "$url" "$target"
    fi
  done

  echo "↳ Installing/upgrading dependencies…"
  for dir in "$CN_DIR"/*/; do
    req="$dir/requirements.txt"
    if [ -f "$req" ]; then
      echo "  ↳ pip install --upgrade -r $req"
      pip install --no-cache-dir --upgrade -r "$req"
    fi
  done

  # Create marker file
  touch "$INIT_MARKER"
else
  echo "↳ Custom nodes already initialized, skipping clone and dependency installation."
fi

echo "↳ Launching ComfyUI"
exec "$@"
