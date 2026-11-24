#!/usr/bin/env bash
set -Eeuo pipefail

# Export every component defined in structured_math_updated.json.
# Usage: ./export_stl_updated.bash [path/to/model.scad] [output_directory]

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SCAD_FILE="${1:-$SCRIPT_DIR/UEB_braille_alphabet_and_word_board.scad}"
OUTPUT_DIR="${2:-$SCRIPT_DIR/exported_stls}"
PARAM_FILE="$SCRIPT_DIR/structured_math_updated.json"

if [[ ! -f "$SCAD_FILE" ]]; then
  echo "ERROR: OpenSCAD source not found: $SCAD_FILE" >&2
  echo "Pass the .scad path as the first argument." >&2
  exit 1
fi
if [[ ! -f "$PARAM_FILE" ]]; then
  echo "ERROR: Parameter file not found: $PARAM_FILE" >&2
  exit 1
fi
command -v python3 >/dev/null 2>&1 || { echo "ERROR: python3 is required to read the JSON parameter sets." >&2; exit 1; }

# Use native OpenSCAD when available; otherwise use the Flatpak package.
if command -v openscad >/dev/null 2>&1; then
  OPENSCAD=(openscad)
elif command -v flatpak >/dev/null 2>&1 && flatpak info org.openscad.OpenSCAD >/dev/null 2>&1; then
  OPENSCAD=(flatpak run org.openscad.OpenSCAD)
else
  echo "ERROR: OpenSCAD was not found. Install it or add it to PATH." >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
mapfile -t COMPONENTS < <(python3 - "$PARAM_FILE" <<'PY'
import json, sys
with open(sys.argv[1], encoding="utf-8") as f:
    data = json.load(f)
for name in data.get("parameterSets", {}):
    print(name)
PY
)

if (( ${#COMPONENTS[@]} == 0 )); then
  echo "ERROR: No parameter sets found in $PARAM_FILE" >&2
  exit 1
fi

failed=0
count=0
for component in "${COMPONENTS[@]}"; do
  output_file="$OUTPUT_DIR/${component}.stl"
  echo "[$((++count))/${#COMPONENTS[@]}] Exporting $component"
  if "${OPENSCAD[@]}" -o "$output_file" -p "$PARAM_FILE" -P "$component" "$SCAD_FILE"; then
    echo "  OK: $output_file"
  else
    echo "  FAILED: $component" >&2
    failed=1
  fi
done

if (( failed )); then
  echo "Export completed with errors. Review the messages above." >&2
  exit 1
fi
echo "Export complete: ${#COMPONENTS[@]} STL files in $OUTPUT_DIR"
