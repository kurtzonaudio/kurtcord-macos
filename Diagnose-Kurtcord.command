#!/bin/bash
# Kurtcord macOS diagnostic tool.
# Read-only: it does not modify the app or your settings.
set -u

REPORT="$HOME/Desktop/Kurtcord-Diagnose.txt"
exec > >(tee "$REPORT") 2>&1

pause() {
  echo
  read -r -n 1 -s -p "Press any key to close this window..." || true
  echo
}

echo "Kurtcord macOS diagnostic"
echo "Date: $(date)"
echo "macOS: $(sw_vers -productVersion) ($(sw_vers -buildVersion))"
echo "Arch: $(uname -m)"
echo

echo "== System security =="
csrutil status 2>&1 || true
spctl --status 2>&1 || true
echo

echo "== Downloads =="
ls -lh "$HOME/Downloads" 2>/dev/null | grep -i kurtcord || echo "(no Kurtcord files in Downloads)"
echo

echo "== DMG checksums =="
for f in "$HOME"/Downloads/Kurtcord-*.dmg; do
  [ -f "$f" ] || continue
  echo "$f"
  shasum -a 256 "$f"
done
echo

APP=""
for p in "/Applications/Kurtcord.app" "$HOME/Applications/Kurtcord.app" "/Volumes/Kurtcord/Kurtcord.app" "$HOME/Downloads/Kurtcord.app"; do
  if [ -d "$p" ]; then APP="$p"; break; fi
done

echo "== Installed app =="
if [ -z "$APP" ]; then
  echo "Kurtcord.app was not found in /Applications, ~/Applications, the mounted DMG, or ~/Downloads."
  echo "Mount the DMG and drag Kurtcord to Applications, then run this again."
  pause
  exit 0
fi
echo "App: $APP"
/usr/libexec/PlistBuddy -c 'Print :CFBundleIdentifier' "$APP/Contents/Info.plist" 2>&1 || true
/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$APP/Contents/Info.plist" 2>&1 || true
echo

echo "== Binary architecture =="
file "$APP/Contents/MacOS/Kurtcord" 2>&1 || true
echo

echo "== Quarantine and extended attributes =="
xattr -l "$APP" 2>&1 || true
echo

echo "== Code signature =="
codesign -dv --verbose=4 "$APP" 2>&1 | head -25 || true
echo
codesign --verify --deep --strict --verbose=4 "$APP" 2>&1 || true
echo

echo "== Gatekeeper assessment =="
echo "(An ad-hoc signed app is expected to be rejected here. The code signature and launch output are the important parts.)"
spctl --assess --type execute --verbose=4 "$APP" 2>&1 || true
echo

echo "== Launch attempt =="
LOG="/tmp/kurtcord-launch.log"
rm -f "$LOG"
"$APP/Contents/MacOS/Kurtcord" --no-sandbox >"$LOG" 2>&1 &
PID=$!
sleep 12
if kill -0 "$PID" 2>/dev/null; then
  echo "The main process is still running after 12 seconds (PID $PID)."
  kill "$PID" 2>/dev/null || true
else
  wait "$PID" 2>/dev/null
  echo "The main process exited. Exit status: $?"
fi
echo "-- launch output --"
head -100 "$LOG" 2>/dev/null || true
echo

echo "== Recent Kurtcord crash reports =="
CRASH_DIR="$HOME/Library/Logs/DiagnosticReports"
if [ -d "$CRASH_DIR" ]; then
  ls -lt "$CRASH_DIR" 2>/dev/null | head -15 || true
  NEWEST=$(ls -t "$CRASH_DIR"/Kurtcord* 2>/dev/null | head -1)
  if [ -n "$NEWEST" ]; then
    echo "-- $NEWEST --"
    head -120 "$NEWEST" 2>/dev/null || true
  else
    echo "(no Kurtcord crash reports found)"
  fi
else
  echo "(no DiagnosticReports directory)"
fi
echo

echo "== User data =="
ls -la "$HOME/Library/Application Support" 2>/dev/null | grep -i kurtcord || echo "(no Kurtcord user data)"
echo

echo "Diagnostic complete."
echo "Report saved to: $REPORT"
echo "Send that file to Kurtzon for review."
pause
