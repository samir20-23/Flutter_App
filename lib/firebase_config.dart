// lib/firebase_config.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseConfig {
  static Future<void> init() async {
    await Firebase.initializeApp();
  }
  static DatabaseReference ref(String path) =>
      FirebaseDatabase.instance.ref(path);
}
