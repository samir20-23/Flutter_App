
# 🚀 **FULL Flutter Mobile App Setup in VS Code (No Android Studio / USB)**

---

## 🔧 1. Install Flutter SDK (Windows)

```powershell
# Download ZIP
Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.0.5-stable.zip" -OutFile "flutter.zip"

# Extract
Expand-Archive flutter.zip -DestinationPath C:\flutter

# Set PATH
setx PATH "$Env:PATH;C:\flutter\bin"
```

✅ Test:

```powershell
flutter --version
```

---

## ☕ 2. Install Java JDK 17+

* Download Temurin 17 (.msi):
  👉 [https://adoptium.net/en-GB/temurin/releases/?version=17](https://adoptium.net/en-GB/temurin/releases/?version=17)

* After install:

```powershell
$env:JAVA_HOME = "C:\Program Files\Eclipse Adoptium\jdk-17.x.x"
$env:PATH += ";$env:JAVA_HOME\bin"
```

✅ Test:

```powershell
java -version
```

---

## 📦 3. Install Android SDK (Command Line Only)

* Download cmdline-tools ZIP:
  👉 [https://developer.android.com/studio#cmdline-tools](https://developer.android.com/studio#cmdline-tools)

* Extract:

```powershell
Expand-Archive commandlinetools-win.zip -DestinationPath C:\android-sdk\cmdline-tools\latest
```

* Set environment:

```powershell
$env:ANDROID_SDK_ROOT = "C:\android-sdk"
$env:PATH += ";C:\android-sdk\cmdline-tools\latest\bin;C:\android-sdk\platform-tools;C:\android-sdk\emulator"
```

---

## 📥 4. Install Android Platform Tools & Image

```powershell
sdkmanager --licenses
sdkmanager `
  "platform-tools" `
  "emulator" `
  "platforms;android-33" `
  "system-images;android-33;google_apis;x86_64"
```

✅ Accept with `y` until done.

---

## 📱 5. Create Android Emulator (Phone Cover)

```powershell
avdmanager create avd --name Pixel_33 `
  --package "system-images;android-33;google_apis;x86_64" `
  --device "pixel"
```

---

## ▶️ 6. Start Emulator & Run Flutter App

```powershell
# Start emulator:
emulator -avd Pixel_33

# In another terminal:
cd C:\MyFlutterProjects\Flutter_App
flutter run -d Pixel_33
```

💡 Use `flutter devices` to list connected emulators.

---

## 🧪 7. Check Setup with Flutter Doctor

```powershell
flutter doctor
```

Fix all ❌ until you see ✅ for:

* Flutter
* Android SDK
* Android toolchain
* Java
* Device (emulator)

---

## 🧱 8. Create New Flutter App

```powershell
cd C:\MyFlutterProjects
flutter create my_app
cd my_app
code .
```

---

## 🔄 9. Hot Reload / Restart

In VS Code:

* **r** → Hot Reload
* **R** → Hot Restart
* **q** → Quit app

Or use VS Code buttons in status bar.

---

## 📦 10. Add Packages (like HTTP or Firebase)

Example: Add HTTP package

**pubspec.yaml:**

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
```

Then run:

```bash
flutter pub get
```

Use in code:

```dart
import 'package:http/http.dart' as http;
```

---

## 🧠 11. Run on Real Phone without USB (Optional)

You can build APK and send it to your phone manually:

```powershell
flutter build apk
# output → build\app\outputs\flutter-apk\app-release.apk
```

Then send it via Telegram, USB file copy, or upload to cloud.

---

## 🎯 12. Common Flutter Commands

```bash
flutter pub get         # Install packages
flutter doctor          # Check environment
flutter run -d <id>     # Run on device/emulator
flutter clean           # Reset project build
flutter build apk       # Create APK
flutter emulators       # List available emulators
flutter devices         # List connected devices
```

---

## 💥 13. Fix Common Errors

| ❌ Error                | ✅ Fix                             |
| ---------------------- | --------------------------------- |
| `emulator not found`   | Java not installed or PATH broken |
| `sdkmanager not found` | Wrong PATH for SDK                |
| `device not found`     | Emulator not running              |
| `flutter doctor ❌`     | Follow the missing tool's setup   |

---

## 🔁 14. VS Code Extensions You NEED

* ✅ Flutter (by Dart Code)
* ✅ Dart (by Dart Code)
* 📱 Android iOS Emulator (optional)
* 🔁 Flutter Snippets (speed up UI coding)

---

## 🧪 15. Testing Your App

```bash
flutter test
```

Example test file:

```dart
void main() {
  test('Simple addition test', () {
    expect(2 + 2, 4);
  });
}
```

---

## 📂 16. Suggested Folder Structure

```plaintext
lib/
├── main.dart
├── screens/
│   └── home_screen.dart
├── widgets/
│   └── my_button.dart
├── services/
│   └── api_service.dart
```

---

## 📤 17. Deploy APK

```bash
flutter build apk --release
```

Then send APK to phone, install it manually.

---

## 📁 18. Backup Your Flutter Project to GitHub

```bash
git init
git add .
git commit -m "initial"
gh repo create my_flutter_app --public --source=. --push
```

