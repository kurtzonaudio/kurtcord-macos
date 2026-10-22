#!/bin/bash
# Kurtcord repair/install tool for macOS.
# Copies Kurtcord to Applications, clears the download quarantine flag,
# re-signs it for this Mac, verifies it, and opens it.
set -euo pipefail

pause() {
  echo
  read -r -n 1 -s -p "Press any key to close this window..." || true
  echo
}
trap 'echo; echo "Repair failed. Run Diagnose-Kurtcord.command and send the report."; pause' ERR

echo "Kurtcord repair tool"
echo "macOS: $(sw_vers -productVersion) ($(sw_vers -buildVersion))"
echo "Arch: $(uname -m)"
echo

APP=""
for p in "/Applications/Kurtcord.app" "$HOME/Applications/Kurtcord.app" "/Volumes/Kurtcord/Kurtcord.app" "$HOME/Downloads/Kurtcord.app"; do
  if [ -d "$p" ]; then APP="$p"; break; fi
done

if [ -z "$APP" ]; then
  echo "Kurtcord.app was not found."
  echo "Mount the Kurtcord DMG first, or drag Kurtcord.app to Applications, then run this again."
  pause
  exit 1
fi

echo "Found: $APP"
echo

if [ "$(uname -m)" = "arm64" ]; then
  if file "$APP/Contents/MacOS/Kurtcord" | grep -q "x86_64"; then
    echo "WARNING: this is the Intel (x64) build on an Apple Silicon Mac."
    echo "Download the arm64 DMG instead:"
    echo "https://github.com/kurtzonaudio/kurtcord-macos/releases/latest"
    echo
  fi
else
  echo "WARNING: this Mac is Intel; use the x64 DMG."
  echo
fi

if [ -w "/Applications" ]; then
  DEST="/Applications/Kurtcord.app"
else
  DEST="$HOME/Applications/Kurtcord.app"
  mkdir -p "$HOME/Applications"
fi

echo "Installing to: $DEST"
pkill -x Kurtcord >/dev/null 2>&1 || true
sleep 1

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
ditto "$APP" "$TMP/Kurtcord.app"
rm -rf "$DEST"
ditto "$TMP/Kurtcord.app" "$DEST"

echo "Clearing quarantine and extended attributes..."
xattr -cr "$DEST" 2>/dev/null || true

echo "Signing for this Mac..."
codesign --force --deep --sign - "$DEST"
codesign --verify --deep --strict "$DEST"

echo "Opening Kurtcord..."
open "$DEST"

echo
echo "Done. If macOS still blocks it, open System Settings > Privacy & Security"
echo "and click Open Anyway next to Kurtcord. Then try again."
pause
