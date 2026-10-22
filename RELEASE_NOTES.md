# Kurtcord 2.8.3 for macOS

The full Kurtcord client, packaged as a native Mac app. This release is
macOS-only.

## Downloads

| Mac | File |
| --- | --- |
| Apple Silicon (M1/M2/M3/M4) | `Kurtcord-2.8.3-mac-arm64.dmg` |
| Intel | `Kurtcord-2.8.3-mac-x64.dmg` |
| Checksums | `SHA256SUMS.txt` |

Check your Mac with **Apple menu → About This Mac → Chip / Processor**. If
you are unsure, use the **arm64** DMG; every Mac sold since late 2020 is
Apple Silicon.

## Quick start

1. Download the DMG for your Mac.
2. Double-click it to mount it.
3. Drag **Kurtcord** into **Applications**.
   Or double-click **Install Kurtcord.command** to install and launch it.
4. On first launch, **right-click Kurtcord → Open**. This is required once
   because the app is ad-hoc signed and not notarized by Apple.
5. Grant **Microphone**, **Camera**, and **Screen Recording** when macOS asks.
   After enabling Screen Recording, quit and reopen Kurtcord.

The full step-by-step tutorial, troubleshooting, and uninstall instructions
are in the [README](https://github.com/kurtzonaudio/kurtcord-macos#step-by-step-tutorial).

## Compatibility

- Native **arm64** build for every Apple Silicon Mac, including **M5, M5 Pro,
  and M5 Max**.
- Verified on **macOS 26.6.2 (Tahoe) arm64**: the DMG mounts, the app is
  Mach-O arm64, the bundle is `com.kurtcord.desktop` version 2.8.3, and
  `codesign --verify --deep --strict` passes.
- Requires macOS 11 (Big Sur) or newer. Use the x64 DMG only on Intel Macs.

## What is included

- Equicord, the Kurtcord userscript, voice/audio panel, RNNoise and
  DeepFilterNet noise suppression, E2EE, screenshare picker, tray menu,
  config sync, and plugins.
- Native macOS app menu and menu-bar icon.
- Microphone, camera, and screen-recording permission handling.
- Apple Silicon and Intel builds.
- Requires macOS 11 (Big Sur) or newer.

## Having trouble launching?

On an M-series Mac, make sure you downloaded the **arm64** DMG. macOS 27 does
not automatically restore Rosetta, so the x64 DMG may not launch on Apple
Silicon.

Repair tool:

```bash
curl -fsSL https://raw.githubusercontent.com/kurtzonaudio/kurtcord-macos/main/Repair-Kurtcord.command -o ~/Downloads/Repair-Kurtcord.command
chmod +x ~/Downloads/Repair-Kurtcord.command
~/Downloads/Repair-Kurtcord.command
```

If it still will not launch, collect a diagnostic report and send it:

```bash
curl -fsSL https://raw.githubusercontent.com/kurtzonaudio/kurtcord-macos/main/Diagnose-Kurtcord.command -o ~/Downloads/Diagnose-Kurtcord.command
chmod +x ~/Downloads/Diagnose-Kurtcord.command
~/Downloads/Diagnose-Kurtcord.command
```

The report is saved to `~/Desktop/Kurtcord-Diagnose.txt`.

If the repair tool still does not help, try the Electron 45 test build for
macOS 27:

https://github.com/kurtzonaudio/kurtcord-macos/releases/tag/v2.8.3-macos27

## Signing

The apps are ad-hoc signed and were verified with
`codesign --verify --deep --strict`; the DMGs were verified with
`hdiutil verify`. They are not notarized, so the first launch needs
right-click **Open**. No Apple Developer account is required.

## License

MIT. See `LICENSE`.
