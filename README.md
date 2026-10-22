# Kurtcord for macOS

**Kurtcord 2.8.3 for macOS** — the full Kurtcord client, packaged as a native
Mac app. This repository is the macOS-only home for Kurtcord. The Windows
client lives in the separate [`kurtcord`](https://github.com/kurtzonaudio/kurtcord)
repository.

[**Download the latest macOS release**](https://github.com/kurtzonaudio/kurtcord-macos/releases/latest)

![Platform](https://img.shields.io/badge/platform-macOS%2011%2B-black)
![Architectures](https://img.shields.io/badge/arch-Apple%20Silicon%20%7C%20Intel-blue)
![License](https://img.shields.io/badge/license-MIT-green)

> Kurtcord is not affiliated with Discord Inc.

---

## Contents

- [What you get](#what-you-get)
- [Which DMG do I need?](#which-dmg-do-i-need)
- [Step-by-step tutorial](#step-by-step-tutorial)
  - [1. Download the DMG](#1-download-the-dmg)
  - [2. Verify the download (optional)](#2-verify-the-download-optional)
  - [3. Mount the DMG](#3-mount-the-dmg)
  - [4. Install Kurtcord](#4-install-kurtcord)
  - [5. Eject the DMG](#5-eject-the-dmg)
  - [6. First launch](#6-first-launch)
  - [7. Grant permissions](#7-grant-permissions)
  - [8. Sign in](#8-sign-in)
- [Updating](#updating)
- [Uninstalling](#uninstalling)
- [Troubleshooting](#troubleshooting)
- [Signing and Gatekeeper](#signing-and-gatekeeper)
- [License](#license)

---

## What you get

- The full Kurtcord client: Equicord, the Kurtcord voice and audio panel,
  RNNoise and DeepFilterNet noise suppression, E2EE, the screenshare picker,
  the menu-bar tray, config sync, and plugins.
- A native macOS application menu and menu-bar icon.
- Proper macOS Microphone, Camera, and Screen Recording permission handling.
- A standard Mac install experience: open the DMG, drag Kurtcord to
  Applications, and launch it.
- Apple Silicon and Intel builds.

**Requires macOS 11 (Big Sur) or newer.**

This repository hosts the macOS builds and documentation. The Kurtcord source
is not published here. Windows releases are in the separate
[`kurtcord`](https://github.com/kurtzonaudio/kurtcord) repository.

---

## Which DMG do I need?

| Your Mac | Download |
| --- | --- |
| Apple Silicon — M1, M2, M3, M4, M5, or newer | `Kurtcord-2.8.3-mac-arm64.dmg` |
| Intel — Core i5, i7, i9, Xeon | `Kurtcord-2.8.3-mac-x64.dmg` |

To check:

1. Click the **Apple menu** in the top-left corner.
2. Choose **About This Mac**.
3. Look at **Chip** or **Processor**:
   - **Apple M1 / M2 / M3 / M4** → use the **arm64** DMG.
   - **Intel Core** → use the **x64** DMG.

If you are not sure, download the **arm64** DMG. If your Mac has an Apple
M-series chip, that is the right build. The x64 build also runs on Apple
Silicon through Rosetta, but the arm64 build is faster and is the recommended
one.

### Apple Silicon and macOS 26

The `arm64` DMG is a native build for every Apple Silicon Mac, including
**M5, M5 Pro, and M5 Max**. It was verified on macOS 26.6.2 (Tahoe) arm64:
the DMG mounts, the app is Mach-O arm64, the bundle identity is
`com.kurtcord.desktop` version 2.8.3, and the code signature validates with
`codesign --verify --deep --strict`.

M5 Macs use the same arm64 architecture and macOS 26, so the arm64 DMG is the
correct build. Use the x64 DMG only on Intel Macs.

The GUI launch itself was not run on the headless CI runner (macOS runners
cannot open a normal app window), so the final click-through should be done
on the Mac. The bundle, architecture, OS compatibility, and signature are
confirmed.

---

## Step-by-step tutorial

### 1. Download the DMG

1. Open the [latest release](https://github.com/kurtzonaudio/kurtcord-macos/releases/latest).
2. Download the DMG that matches your Mac:
   - `Kurtcord-2.8.3-mac-arm64.dmg`
   - `Kurtcord-2.8.3-mac-x64.dmg`
3. Also download `SHA256SUMS.txt` if you want to verify the file.

The DMG usually lands in your **Downloads** folder.

### 2. Verify the download (optional)

This checks that the file downloaded completely and was not modified.

1. Open **Terminal** (Applications → Utilities → Terminal, or press
   `Cmd + Space`, type `Terminal`, and press Return).
2. Run the command for the file you downloaded:

   ```bash
   cd ~/Downloads
   shasum -a 256 Kurtcord-2.8.3-mac-arm64.dmg
   ```

   For Intel:

   ```bash
   shasum -a 256 Kurtcord-2.8.3-mac-x64.dmg
   ```

3. Compare the long string it prints with the matching line in
   `SHA256SUMS.txt`. They must match exactly.

If they do not match, delete the DMG and download it again.

### 3. Mount the DMG

Mounting a DMG means opening it so macOS shows its contents as a disk.

**With Finder (normal way):**

1. Double-click the `.dmg` file.
2. A Finder window opens showing **Kurtcord** and **Applications**.
3. The disk also appears in the Finder sidebar under **Locations** and on the
   Desktop as **Kurtcord**.

**With Terminal (alternative):**

```bash
hdiutil attach ~/Downloads/Kurtcord-2.8.3-mac-arm64.dmg
```

The volume mounts at `/Volumes/Kurtcord`. When you are done, detach it with:

```bash
hdiutil detach /Volumes/Kurtcord
```

**If macOS will not open the DMG:**

- Right-click the `.dmg` and choose **Open**, then **Open** again.
- Or open **System Settings → Privacy & Security**, scroll down, and click
  **Open Anyway** next to the Kurtcord message.
- If it still fails, re-download the file and verify the SHA-256 checksum.

### 4. Install Kurtcord

You have two options. Both end with the app in `/Applications`.

**Option A — drag it (recommended, standard Mac way):**

1. In the DMG window, drag **Kurtcord** onto the **Applications** folder icon.
2. Wait for the copy to finish.
3. Eject the DMG (see the next step).

**Option B — use the included installer:**

1. In the DMG window, double-click **Install Kurtcord.command**.
2. If macOS blocks the script, right-click it and choose **Open**.
   You can also run it from Terminal:

   ```bash
   bash "/Volumes/Kurtcord/Install Kurtcord.command"
   ```

3. The installer copies Kurtcord to `/Applications`, removes the download
   quarantine flag, signs the app for your Mac, and opens it.

**Terminal manual install:**

```bash
cp -R "/Volumes/Kurtcord/Kurtcord.app" /Applications/
xattr -cr "/Applications/Kurtcord.app"
codesign --force --deep --sign - "/Applications/Kurtcord.app"
```

### 5. Eject the DMG

1. In Finder, click the **eject** button (⏏) next to **Kurtcord** in the
   sidebar.
2. Or drag the **Kurtcord** disk icon on the Desktop to the Trash.
3. Or run:

   ```bash
   hdiutil detach /Volumes/Kurtcord
   ```

Do not leave the app running from inside the DMG. Drag it to Applications
first.

### 6. First launch

1. Open **Applications** in Finder.
2. Find **Kurtcord**.
3. **Right-click** (or Control-click) **Kurtcord** and choose **Open**.
4. A dialog appears. Click **Open** again.

This one-time step is required because the app is ad-hoc signed, not
notarized by Apple. After the first launch, a normal double-click works.

If you do not see an **Open** option:

1. Open **System Settings → Privacy & Security**.
2. Scroll down to the message about Kurtcord.
3. Click **Open Anyway**.
4. Confirm with your Mac password or Touch ID.

If macOS says **“Kurtcord is damaged and can’t be opened”**, see
[Troubleshooting](#troubleshooting).

### 7. Grant permissions

Kurtcord asks for permissions the first time you use each feature. Allow them
so voice, video, and screen sharing work.

| Permission | What it is for | Where to enable |
| --- | --- | --- |
| **Microphone** | Voice calls and voice messages | System Settings → Privacy & Security → Microphone |
| **Camera** | Video calls and camera preview | System Settings → Privacy & Security → Camera |
| **Screen Recording** | Sharing your screen or a window | System Settings → Privacy & Security → Screen Recording |

Notes:

- If Kurtcord is not listed, open Kurtcord, try the action once, then check
  the list again.
- After enabling **Screen Recording**, **quit Kurtcord and reopen it**. macOS
  only applies screen-capture permission on the next launch.
- The **Kurtcord** menu in the menu bar has direct shortcuts to the
  Microphone, Camera, and Screen Recording panes.

### 8. Sign in

1. Open Kurtcord.
2. Log in with your Discord account.
3. Open Kurtcord's settings to configure your microphone, output device,
   noise suppression, bitrate, and the rest of the voice/audio panel.

Your settings are stored in:

```
~/Library/Application Support/Kurtcord
```

---

## Updating

1. Download the new DMG from the [releases page](https://github.com/kurtzonaudio/kurtcord-macos/releases).
2. Mount it.
3. Drag **Kurtcord** to **Applications**.
4. When macOS asks, choose **Replace**.
5. Eject the DMG.
6. Right-click **Kurtcord → Open** once for the new version.

Your settings and login stay in `~/Library/Application Support/Kurtcord`.

---

## Uninstalling

1. Quit Kurtcord (`Cmd + Q`).
2. Open **Applications**.
3. Drag **Kurtcord** to the Trash.
4. Empty the Trash.

To also remove settings, caches, and login data:

```bash
rm -rf ~/Library/Application\ Support/Kurtcord
rm -rf ~/Library/Caches/Kurtcord
rm -rf ~/Library/Caches/com.kurtcord.desktop
```

---

## Troubleshooting

### “Kurtcord can’t be opened because Apple cannot check it for malicious software”

This is the normal Gatekeeper warning for an ad-hoc signed app.

1. Right-click **Kurtcord** in Applications.
2. Choose **Open**.
3. Click **Open** in the dialog.

Or use **System Settings → Privacy & Security → Open Anyway**.

### “Kurtcord is damaged and can’t be opened”

This usually means the quarantine flag or the local signature needs to be
refreshed. Open Terminal and run:

```bash
xattr -cr /Applications/Kurtcord.app
codesign --force --deep --sign - /Applications/Kurtcord.app
open /Applications/Kurtcord.app
```

If it still fails, delete the app, re-download the DMG, and verify the
SHA-256 checksum. Also make sure you downloaded the right architecture:
arm64 for Apple Silicon, x64 for Intel.

### “Kurtcord cannot be opened” on macOS 27, or nothing happens

First check the architecture. On an M-series Mac (including M5), use the
**arm64** DMG. macOS 27 does not automatically restore Rosetta, so the x64
DMG may not launch on Apple Silicon.

Then run the repair tool. Open **Terminal** and paste:

```bash
curl -fsSL https://raw.githubusercontent.com/kurtzonaudio/kurtcord-macos/main/Repair-Kurtcord.command -o ~/Downloads/Repair-Kurtcord.command
chmod +x ~/Downloads/Repair-Kurtcord.command
~/Downloads/Repair-Kurtcord.command
```

It copies Kurtcord to Applications, clears the download quarantine flag,
re-signs the app for your Mac, verifies it, and opens it.

If it still does not launch, run the diagnostic tool:

```bash
curl -fsSL https://raw.githubusercontent.com/kurtzonaudio/kurtcord-macos/main/Diagnose-Kurtcord.command -o ~/Downloads/Diagnose-Kurtcord.command
chmod +x ~/Downloads/Diagnose-Kurtcord.command
~/Downloads/Diagnose-Kurtcord.command
```

The report is saved to `~/Desktop/Kurtcord-Diagnose.txt`. It shows the exact
Gatekeeper, signature, architecture, and crash reason. Send that file for
review.

These tools do not disable Gatekeeper or SIP. They only clear the quarantine
flag and re-sign the app locally.

### The DMG will not open

1. Right-click the `.dmg` and choose **Open**.
2. If that fails, clear its quarantine flag and open it again:

   ```bash
   xattr -cr ~/Downloads/Kurtcord-2.8.3-mac-arm64.dmg
   open ~/Downloads/Kurtcord-2.8.3-mac-arm64.dmg
   ```

3. If it still fails, re-download the file and check it against
   `SHA256SUMS.txt`.

### No microphone or camera

1. Open **System Settings → Privacy & Security → Microphone** (or **Camera**).
2. Enable **Kurtcord**.
3. Quit Kurtcord completely (`Cmd + Q`) and reopen it.

If Kurtcord is not in the list, join a call or open the voice settings once,
then check again.

### Screen sharing is black or won’t start

1. Open **System Settings → Privacy & Security → Screen Recording**.
2. Enable **Kurtcord**.
3. Quit Kurtcord and reopen it.
4. Try sharing again.

On newer macOS versions, macOS may ask you to confirm screen recording when
you start sharing. Accept the prompt.

### The app opens but Discord does not load

1. Check your internet connection.
2. Quit Kurtcord and reopen it.
3. Make sure macOS is not blocking Discord in a firewall or VPN.
4. Try the other network (for example, turn off the VPN briefly) to rule out
   a network issue.

### The window is blank or the UI looks wrong

1. Quit Kurtcord.
2. Reopen it.
3. If it persists, uninstall and reinstall the DMG.

### I downloaded the wrong architecture

- Apple Silicon needs the **arm64** DMG.
- Intel needs the **x64** DMG.

Download the correct one, replace the app in Applications, and right-click
Open once.

---

## Signing and Gatekeeper

The DMGs are ad-hoc signed during the macOS build and verified with:

```bash
codesign --verify --deep --strict /Applications/Kurtcord.app
```

The disk images themselves are verified with `hdiutil verify`.

They are **not notarized by Apple**, so a downloaded copy needs one
right-click **Open** on first launch. That is expected and does not indicate
a problem. No Apple Developer account is required to install or use Kurtcord.

If you want fully silent, warning-free double-click launches, the app must be
signed with an Apple Developer ID certificate and notarized by Apple.

---

## License

MIT — see [LICENSE](LICENSE).

Kurtcord itself is MIT-licensed. Bundled third-party components such as
Electron and Equicord retain their own licenses.
