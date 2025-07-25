// File: lib/location_controller.dart
import 'dart:async';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_config.dart';
import 'device_id_service.dart';

class LocationController extends GetxController {
  final RxList<LatLng> path = <LatLng>[].obs;
  final Rxn<LatLng> currentPos = Rxn<LatLng>();
  final RxMap<String, LatLng> others = <String, LatLng>{}.obs;
  Timer? _timer;
  late final String _deviceId;
  late final DatabaseReference _myRef;
  late final DatabaseReference _allRef;

  bool get isTracking => _timer?.isActive ?? false;

  @override
  void onInit() {
    super.onInit();
    _setup();
  }

  Future<void> _setup() async {
    _deviceId = await DeviceIdService.getId();
    _myRef = FirebaseConfig.ref('cars/$_deviceId');
    _allRef = FirebaseConfig.ref('cars');
    _allRef.onValue.listen((e) {
      final data = e.snapshot.value as Map<dynamic, dynamic>? ?? {};
      others.clear();
      data.forEach((k, v) {
        final lat = (v['lat'] as num).toDouble();
        final lng = (v['lng'] as num).toDouble();
        others[k.toString()] = LatLng(lat, lng);
      });
    });
    _startTracking();
  }

  @override
  void onClose() {
    _timer?.cancel();
    _myRef.remove();
    super.onClose();
  }

  void _startTracking() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 5), (_) => _update());
  }

  Future<void> _update() async {
    if (!await Geolocator.isLocationServiceEnabled()) return;
    var perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) perm = await Geolocator.requestPermission();
    if (perm == LocationPermission.denied || perm == LocationPermission.deniedForever) return;
    Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final ll = LatLng(p.latitude, p.longitude);
    currentPos.value = ll;
    path.add(ll);
    await _myRef.set({'lat': p.latitude, 'lng': p.longitude});
  }

  void restart() => _startTracking();
  void stop() => _timer?.cancel();
}
