// File: lib/device_id_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  static const _key = 'device_id';

  static Future<String> getId() async {
    final prefs = await SharedPreferences.getInstance();
    var id = prefs.getString(_key);
    if (id == null) {
      id = Uuid().v4();
      await prefs.setString(_key, id);
    }
    return id;
  }
}
