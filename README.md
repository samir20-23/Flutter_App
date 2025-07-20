
# my_flutter_app 📱 
satart the android emulator : 
```
C:\android-sdk\emulator\emulator.exe -avd Flutter_AVD -no-audio -gpu swiftshader_indirect
```
A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
Perfect — you already have a `README.md` in your repo, and it starts like this:
  
```
    


    ____________________
    ### Project: GPS Tracker Flutter App
 
---

#### pubspec.yaml

```yaml
name: my_tracker_app
description: A simple GPS tracking Flutter app
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ">=2.18.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  flutter_map: ^4.0.0
  geolocator: ^9.0.2
  get: ^4.6.5
  latlong2: ^0.8.1

flutter:
  uses-material-design: true
```

---

#### android/app/src/main/AndroidManifest.xml

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

    <application
        android:label="my_tracker_app"
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme"/>
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <meta-data android:name="flutterEmbedding" android:value="2"/>
    </application>

    <queries>
        <intent>
            <action android:name="android.intent.action.PROCESS_TEXT"/>
            <data android:mimeType="text/plain"/>
        </intent>
    </queries>
</manifest>
```

---

#### ios/Runner/Info.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<plist version="1.0">
<dict>
  <!-- ... existing keys ... -->
  <key>NSLocationWhenInUseUsageDescription</key>
  <string>This app needs access to your location to show your position on the map.</string>
</dict>
</plist>
```

---

#### lib/main.dart

```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'controllers/location_controller.dart';
import 'iphone_shell.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: iPhoneShell(child: GPSHomePage()),
    ),
  );
}

class GPSHomePage extends StatelessWidget {
  final LocationController locCtrl = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final pos = locCtrl.currentPosition.value;
        if (pos == null) return const Center(child: CircularProgressIndicator());

        return FlutterMap(
          options: MapOptions(
            center: LatLng(pos.latitude, pos.longitude),
            zoom: 14.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(pos.latitude, pos.longitude),
                  width: 60,
                  height: 60,
                  builder: (_) => Icon(Icons.location_pin, size: 40, color: Colors.red),
                ),
              ],
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: () => locCtrl.getLocation(),
      ),
    );
  }
}
```

---

#### lib/controllers/location\_controller.dart

```dart
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  Rx<Position?> currentPosition = Rx<Position?>(null);

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  void getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) return;

    currentPosition.value = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position p) {
      currentPosition.value = p;
    });
  }
}
```

---

#### lib/iphone\_shell.dart

```dart
import 'package:flutter/material.dart';

class iPhoneShell extends StatelessWidget {
  final Widget child;
  const iPhoneShell({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width.clamp(290.0, 330.0);
    final h = w * (844 / 390);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: w,
              height: h,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.grey.shade400, width: 2),
                borderRadius: BorderRadius.circular(48),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 16, offset: Offset(0, 10))],
              ),
            ),
            // side buttons omitted for brevity
            Positioned.fill(
              top: 2, left: 2, right: 2, bottom: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(color: Colors.white, child: child),
              ),
            ),
            // notch and speaker omitted
          ],
        ),
      ),
    );
  }
}
```

---

### 📲 How to run

```bash
cd my_tracker_app
flutter pub get
flutter run
```
