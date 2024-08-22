import 'dart:convert';
import 'package:http/http.dart' as http;

class SensorApiService {
  final String baseUrl = 'http://192.168.224.52:8080';

  Future<Map<String, dynamic>> fetchSensorData() async {
    final response = await http.get(Uri.parse('$baseUrl/other/send'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load sensor data');
    }
  }

  Future<Map<String, dynamic>> confuData() async {
    final response = await http.get(Uri.parse('$baseUrl/confusion/send'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load sensor data');
    }
  }
}
