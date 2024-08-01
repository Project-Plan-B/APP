import 'package:plan_b/src/data/home/dto/request/get_home_list_request.dart';
import 'package:plan_b/main.dart';

abstract class ApplyEvent {}

class GetApplyListEvent extends ApplyEvent {
  final GetApplyListRequest getApplyListRequest;

  GetApplyListEvent({required this.getApplyListRequest});
}

class ApplyCancelEvent extends ApplyEvent {
  final int deviceId;

  ApplyCancelEvent({
    required this.deviceId,
  });
}

class SendFCMEvent extends ApplyEvent {
  final int deviceId;
  final DeviceType deviceType;

  SendFCMEvent({
    required this.deviceId,
    required this.deviceType,
  });
}