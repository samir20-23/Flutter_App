// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'firebase_config.dart';
import 'location_controller.dart';
import 'iphone_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: iPhoneShell(child: GPSHomePage()),
    ),
  );
}

class GPSHomePage extends StatelessWidget {
  final LocationController ctrl = Get.put(LocationController());
  final MapController mapCtrl = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final pos = ctrl.currentPos.value;
        final route = ctrl.path.toList();
        final others = ctrl.others.entries.toList();
        if (pos == null) return const Center(child: CircularProgressIndicator());
        return FlutterMap(
          mapController: mapCtrl,
          options: MapOptions(initialCenter: pos, initialZoom: 15.0),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            PolylineLayer(
              polylines: [
                Polyline(points: route, strokeWidth: 4.0),
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: pos,
                  width: 80,
                  height: 80,
                  child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
                ),
                for (var e in others)
                  Marker(
                    point: e.value,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.directions_car, size: 30, color: Colors.blue),
                  ),
              ],
            ),
          ],
        );
      }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'toggle',
            child: Obx(() => Icon(
              ctrl.isTracking ? Icons.pause_circle_filled : Icons.play_circle_fill
            )),
            onPressed: () => ctrl.isTracking ? ctrl.stop() : ctrl.restart(),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'recenter',
            child: const Icon(Icons.my_location),
            onPressed: () {
              final p = ctrl.currentPos.value;
              if (p != null) mapCtrl.move(p, 15.0);
            },
          ),
        ],
      ),
    );
  }
}
