class SetAlertResponse {
  final bool success;
  final String message;
  final int? roomFloor;
  final String? roomName;
  final int? wantConfusion;

  SetAlertResponse({
    required this.success,
    required this.message,
    this.roomFloor,
    this.roomName,
    this.wantConfusion,
  });

  factory SetAlertResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('message')) {
      return SetAlertResponse(
        success: true,
        message: json['message'],
      );
    } else if (json.containsKey('room_floor')) {
      return SetAlertResponse(
        success: true,
        message: "알림이 성공적으로 설정되었습니다.",
        roomFloor: json['room_floor'],
        roomName: json['room_name'],
        wantConfusion: json['want_confusion'],
      );
    } else {
      return SetAlertResponse(
        success: false,
        message: json['error'] ?? 'Unknown error',
      );
    }
  }
}
