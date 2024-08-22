import 'package:plan_b/src/domain/home/entity/home_entity.dart';

abstract class ApplyEvent {}

class GetApplyListEvent extends ApplyEvent {}

class ApplyCancelEvent extends ApplyEvent {
  final int deviceId;

  ApplyCancelEvent({required this.deviceId});
}

class SetConfusionEvent extends ApplyEvent {
  final int roomId;
  final int confusionLevel;

  SetConfusionEvent({required this.roomId, required this.confusionLevel});
}
