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

## What is included

- Equicord, the Kurtcord userscript, voice/audio panel, RNNoise and
  DeepFilterNet noise suppression, E2EE, screenshare picker, tray menu,
  config sync, and plugins.
- Native macOS app menu and menu-bar icon.
- Microphone, camera, and screen-recording permission handling.
- Apple Silicon and Intel builds.
- Requires macOS 11 (Big Sur) or newer.

## Signing

The apps are ad-hoc signed and were verified with
`codesign --verify --deep --strict`; the DMGs were verified with
`hdiutil verify`. They are not notarized, so the first launch needs
right-click **Open**. No Apple Developer account is required.

## License

MIT. See `LICENSE`.
