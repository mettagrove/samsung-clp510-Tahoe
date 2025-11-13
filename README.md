# samsung-clp510-Tahoe
updated the splix 2.0.1 driver for samsung clp-510 to work with mac os tahoe (26.1)
Samsung CLP-510 – Working macOS Driver (SpliX-based)

This repository contains a fully working macOS driver for the Samsung CLP-510 laser printer.
It includes:

A fixed and patched PPD (clp510.ppd)

Working rastertoqpdl and pstoqpdl SpliX filters

An installer script (install_splix_clp510.sh) to install everything automatically

Works on macOS Ventura, Sonoma, Sequoia and newer.

2. Open Terminal and go to the folder

Example:

cd ~/Downloads/clp510-macos-driver


Check files:

ls -l


Expected output (names must match):

clp510.ppd
rastertoqpdl
pstoqpdl
install_splix_clp510.sh

3. Make installer script executable
chmod +x install_splix_clp510.sh

4. Run the installer (requires sudo)
sudo ./install_splix_clp510.sh

What the script does:

Installs rastertoqpdl → /usr/libexec/cups/filter/

Installs pstoqpdl → /usr/libexec/cups/filter/

Installs clp510.ppd → /Library/Printers/PPDs/Contents/Resources/samsung/

Fixes permissions

Restarts CUPS

🖨️ Add the Printer (Final Step)

Open System Settings → Printers & Scanners

Click Add Printer

Select the Samsung CLP-510 (USB or network)

Under Use: click
“Select Software…”
 choose Other… and select:

/Library/Printers/PPDs/Contents/Resources/samsung/clp510.ppd


The printer should now work immediately.
