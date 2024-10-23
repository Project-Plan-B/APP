import 'package:plan_b/main.dart';
import 'package:plan_b/src/domain/home/entity/home_entity.dart';

class SetAlertResponse {
  final bool success;
  final String message;
  final int roomFloor;
  final String roomName;
  final int Confusion;

  SetAlertResponse({
    required this.success,
    required this.message,
    required this.roomFloor,
    required this.roomName,
    required this.Confusion,
  });

  factory SetAlertResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('message')) {
      return SetAlertResponse(
        success: true,
        message: json['message'],
        roomFloor: 0,
        roomName: '0',
        Confusion: 0,
      );
    } else if (json.containsKey('room_floor')) {
      return SetAlertResponse(
        success: true,
        message: "알림이 성공적으로 설정되었습니다.",
        roomFloor: json['room_floor'],
        roomName: json['room_name'],
        Confusion: json['want_confusion'],
      );
    } else {
      return SetAlertResponse(
        success: false,
        message: json['error'] ?? 'Unknown error',
        roomFloor: 0,
        roomName: '0',
        Confusion: 0,
      );
    }
  }

  ApplyEntity toEntity() => ApplyEntity(
      roomfloor: roomFloor,
      roomName: roomName == "가온실" ? RoomName.gaon : RoomName.test,
      confusion: Confusion,
  );

}
