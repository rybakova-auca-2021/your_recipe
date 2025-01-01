import 'dart:convert';
import 'package:dio/dio.dart';

class DeviceRegistrationService {
  static const String apiUrl = "https://ringtail-renewing-terminally.ngrok-free.app/chefmate/notifications/device/register/";

  static Future<void> registerDevice({
    required String name,
    required String deviceType,
    required String registrationToken,
  }) async {
    try {
      Dio dio = Dio();
      dio.options.headers = {
        "Content-Type": "application/json",
      };
      final data = {
        "name": name,
        "device_type": deviceType,
        "registration_token": registrationToken,
      };
      final response = await dio.post(
        apiUrl,
        data: jsonEncode(data),
      );
      if (response.statusCode == 201) {
        print("Device registered successfully: ${response.data}");
      } else {
        print("Failed to register device: ${response.data}");
      }
    } catch (e) {
      print("Error registering device: $e");
    }
  }
}
