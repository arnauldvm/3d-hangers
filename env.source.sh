
OPENSCAD_PATH_CANDIDATES=()
# Mac OS
OPENSCAD_PATH_CANDIDATES+=("/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD")
OPENSCAD_PATH_CANDIDATES+=("$HOME/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD")
# Windows
OPENSCAD_PATH_CANDIDATES+=("/mnt/c/Program Files/OpenSCAD/openscad.exe")
# Linux
OPENSCAD_PATH_CANDIDATES+=("/usr/bin/openscad")
OPENSCAD_PATH_CANDIDATES+=("/bin/openscad")
# Default
OPENSCAD_PATH_CANDIDATES+=("openscad")

OPENSCAD_PATH=$(
for f in "${OPENSCAD_PATH_CANDIDATES[@]}"; do
    command -v "$f" &> /dev/null && { echo "$f"; break; }
done
)
