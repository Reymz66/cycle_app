---
description: Build a release APK targeting arm64 only (small size, modern phones)
---

When the user runs this command (or asks to "build the apk"), build a release APK scoped to `arm64-v8a` only — this project doesn't need to support old 32-bit (`armeabi-v7a`) or emulator (`x86_64`) targets, and the universal APK is ~3x larger for no benefit on real devices.

```bash
flutter build apk --release --target-platform android-arm64
```

Output: `build/app/outputs/flutter-apk/app-release.apk` (~18-19MB vs ~53MB for the universal build).

Report the final APK size and path when done.
