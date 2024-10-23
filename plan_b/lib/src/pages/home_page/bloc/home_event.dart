import 'package:plan_b/src/domain/home/entity/home_entity.dart';

abstract class ApplyEvent {}

class SetConfusionEvent extends ApplyEvent {
  final int roomId;
  final int confusionLevel;

  SetConfusionEvent({required this.roomId, required this.confusionLevel});
}

class UpdateConfusionEvent extends ApplyEvent {
  final int confusion; // 혼잡도 값을 받을 변수

  UpdateConfusionEvent(this.confusion);
}