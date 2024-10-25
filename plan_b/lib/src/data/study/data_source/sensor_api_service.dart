import 'dart:convert';
import 'package:http/http.dart' as http;

class SensorApiService {
  final String baseUrl = 'http://172.26.10.52:8080';

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
