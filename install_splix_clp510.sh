#!/bin/zsh
# Install SpliX driver (CLP-510) on macOS
# Run with:  sudo ./install_splix_clp510.sh

set -e

# Directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PPD_FILE="$SCRIPT_DIR/clp510.ppd"
FILTER_RASTER="$SCRIPT_DIR/rastertoqpdl"
FILTER_PS="$SCRIPT_DIR/pstoqpdl"

echo "== SpliX CLP-510 installer =="

# Basic checks
if [ ! -f "$PPD_FILE" ]; then
  echo "ERROR: PPD file not found: $PPD_FILE"
  exit 1
fi

if [ ! -f "$FILTER_RASTER" ] || [ ! -f "$FILTER_PS" ]; then
  echo "ERROR: rastertoqpdl or pstoqpdl not found in $SCRIPT_DIR"
  exit 1
fi

echo "Copying filters to /usr/libexec/cups/filter/ ..."
sudo mkdir -p /usr/libexec/cups/filter
sudo cp "$FILTER_RASTER" /usr/libexec/cups/filter/rastertoqpdl
sudo cp "$FILTER_PS" /usr/libexec/cups/filter/pstoqpdl
sudo chmod 755 /usr/libexec/cups/filter/rastertoqpdl
sudo chmod 755 /usr/libexec/cups/filter/pstoqpdl

echo "Copying PPD template to /Library/Printers/PPDs/Contents/Resources/samsung/ ..."
sudo mkdir -p /Library/Printers/PPDs/Contents/Resources/samsung
sudo cp "$PPD_FILE" /Library/Printers/PPDs/Contents/Resources/samsung/clp510.ppd

echo "Restarting CUPS..."
sudo launchctl kickstart -k system/org.cups.cupsd || true

cat <<EOF

Done.

Next steps on this Mac:

1) Plug in / connect the Samsung CLP-510.
2) Open System Settings → Printers & Scanners → Add Printer.
3) When choosing the driver:
   - Click "Use:" → "Select Software..." or "Other..."
   - Choose:  clp510.ppd
     (you'll find it in:
      /Library/Printers/PPDs/Contents/Resources/samsung)

Printing should work immediately with this driver.

EOF
