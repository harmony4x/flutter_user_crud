import 'package:get/get.dart';
import 'package:universal_io/io.dart';

class ApiConfig {
  static String apiBaseUrl = 'http://localhost:3056/'; // Default for web

  static void initialize() {
    if (Platform.isAndroid) {
      apiBaseUrl = 'http://10.0.2.2:3056/'; // Android emulator
    }
    // Add tương tự cho các nền tảng khác (iOS, v.v.)
  }
}
