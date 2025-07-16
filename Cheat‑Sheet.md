 
```bash
#!/usr/bin/env bash
set -e

# 1. Install prerequisites (Ubuntu/Debian example)
sudo apt-get update -y
sudo apt-get install -y git curl unzip xz-utils zip libglu1-mesa default-jdk

# 2. Download & unzip Flutter SDK
FLUTTER_VERSION="stable"
FLUTTER_TAR="flutter_${FLUTTER_VERSION}-linux.tar.xz"
curl -LO "https://storage.googleapis.com/flutter_infra_release/releases/${FLUTTER_TAR}"
tar xf "${FLUTTER_TAR}"
rm "${FLUTTER_TAR}"

# 3. Add flutter to PATH (in this session & permanently)
export PATH="$PWD/flutter/bin:$PATH"
echo 'export PATH="$PWD/flutter/bin:$PATH"' >> ~/.bashrc

# 4. Accept Android licenses & enable web/desktop
flutter doctor --android-licenses <<<'y
flutter channel ${FLUTTER_VERSION}
flutter upgrade
flutter config --enable-web --enable-macos-desktop --enable-windows-desktop --enable-linux-desktop

# 5. Install Android SDK command‑line tools & platform
SDK_ROOT="$HOME/Android/Sdk"
mkdir -p "${SDK_ROOT}/cmdline-tools"
cd "${SDK_ROOT}/cmdline-tools"
curl -LO https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
unzip commandlinetools-linux-*.zip
rm commandlinetools-linux-*.zip
mv cmdline-tools latest

# 6. Add Android SDK to PATH
echo "export ANDROID_SDK_ROOT=${SDK_ROOT}" >> ~/.bashrc
echo 'export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"' >> ~/.bashrc
export ANDROID_SDK_ROOT=${SDK_ROOT}
export PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH"

# 7. Install required SDK packages
yes | sdkmanager --licenses
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# 8. Verify setup
flutter doctor -v

echo "🎉 Flutter & Android SDK installed! Close and reopen your terminal."
```

> * Adjust paths (`ANDROID_SDK_ROOT`) or Android API levels (`android-33`) as needed.
> * On **macOS**, replace `apt-get` with `brew` and Linux URLs with macOS URLs (flutter\_macos\_\*.zip).

---

## 2️⃣ Quick “Cheat‑Sheet” Commands

| Task                              | Command                                                                        |
| --------------------------------- | ------------------------------------------------------------------------------ |
| **Create New App**                | `flutter create my_app`                                                        |
| **Run on Device/Emulator**        | `cd my_app && flutter run`                                                     |
| **Analyze & Format**              | `flutter analyze`  <br/> `flutter format .`                                    |
| **Add Packages**                  | `flutter pub add <package_name>`                                               |
| **Generate Code (build\_runner)** | `flutter pub run build_runner build --delete-conflicting-outputs`              |
| **Build APK (debug/release)**     | `flutter build apk --debug`  <br/> `flutter build apk --release`               |
| **Build iOS (release)**           | `flutter build ios --release`                                                  |
| **Web Build**                     | `flutter build web`                                                            |
| **Windows/macOS/Linux Build**     | `flutter build windows` / `flutter build macos` / `flutter build linux`        |
| **Run Tests**                     | `flutter test`                                                                 |
| **Open DevTools**                 | `flutter pub global activate devtools` <br/> `flutter pub global run devtools` |
| **Clean Build**                   | `flutter clean`                                                                |

---

### 📚 Next Steps

1. **IDE Setup**:

   * **VS Code**: Install the **Flutter** & **Dart** extensions.
   * **Android Studio**: Install **Flutter** & **Dart** plugins in Settings → Plugins.

2. **Project Structure**:

   * Put UI code in `lib/`.
   * Organize by feature (e.g. `lib/features/login/`, `lib/widgets/`).

3. **State Management**:

   * Start simple: `Provider` or `Riverpod`.
   * For larger apps: consider `Bloc`, `GetX`, or `MobX`.

4. **CI/CD & Testing**:

   * Add unit & widget tests in `test/`.
   * Integrate with GitHub Actions or GitLab CI for automated builds.