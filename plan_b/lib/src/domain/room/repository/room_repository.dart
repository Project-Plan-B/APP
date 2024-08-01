import 'dart:async';

import 'package:plan_b/src/domain/room/entity/room_entity.dart';

abstract class LaundryRepository {
  Stream<LaundryEntity> get laundryList;

  void webSocketInit();

  Future<List<LaundryEntity>> getAllLaundryList();

  Future<void> setValue({required String key, required int value});

  int? getValue({required String key});
}
