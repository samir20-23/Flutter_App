// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'controllers/location_controller.dart';

// void main() {
//   runApp(GetMaterialApp(home: MapScreen()));
// }

// class MapScreen extends StatelessWidget {
//   final locationController = Get.put(LocationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('GPS Tracker')),
//       body: Obx(() {
//         final pos = locationController.currentPosition.value;
//         if (pos == null) return Center(child: CircularProgressIndicator());

//         return GoogleMap(
//           initialCameraPosition: CameraPosition(
//             target: LatLng(pos.latitude, pos.longitude),
//             zoom: 16,
//           ),
//           markers: {
//             Marker(
//               markerId: MarkerId('me'),
//               position: LatLng(pos.latitude, pos.longitude),
//             )
//           },
//         );
//       }),
//     );
//   }
// }
