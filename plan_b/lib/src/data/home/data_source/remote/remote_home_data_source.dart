import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan_b/src/data/home/dto/response/set_alert_response.dart';
import 'package:plan_b/src/init/fcm_init.dart';

class RemoteApplyDataSource {
  final String baseUrl = "http://192.168.224.52:8080";

  RemoteApplyDataSource() {
    FlutterLocalNotification.init(); // 알림 초기화
  }

  // 혼잡도 변경 요청 메서드
  Future<SetAlertResponse> setConfusionAlert({required int roomId, required int confusionLevel}) async {
    final url = Uri.parse("$baseUrl/alert/$roomId");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"want_confusion": confusionLevel}),
    );

    if (response.statusCode == 200) {
      // 200 응답 시 알림을 표시
      FlutterLocalNotification.showNotification(
        "혼잡도 변경 성공",
        "혼잡도가 성공적으로 변경되었습니다.",
      );
      return SetAlertResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 201) {
      return SetAlertResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to change confusion level: ${response.body}");
    }
  }
}
