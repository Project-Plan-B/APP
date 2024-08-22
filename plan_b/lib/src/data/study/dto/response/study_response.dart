import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/main.dart';

class LaundryResponse {
  final int id;
  final int state;
  final String deviceType;

  const LaundryResponse({
    required this.id,
    required this.state,
    required this.deviceType,
  });

  factory LaundryResponse.fromJson(Map<String, dynamic> json) {
    return LaundryResponse(
      id: json['id'],
      state: json['state'],
      deviceType: json['device_type'],
    );
  }

  LaundryEntity toEntity() {
    return LaundryEntity(
      id: id,
      state: CurrentState.values.elementAt(state),
      deviceType: deviceType == "GAON"
          ? DeviceType.gaon
          : deviceType == "DAON"
              ? DeviceType.daon
              : DeviceType.empty,
    );
  }
}
