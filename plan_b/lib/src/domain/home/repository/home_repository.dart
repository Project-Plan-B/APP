import 'dart:async';

import 'package:plan_b/src/data/home/dto/request/home_cancel_request.dart';
import 'package:plan_b/src/domain/home/entity/home_entity.dart';

abstract class ApplyRepository {
  Future<List<ApplyEntity>> getApplyList();

  Future<void> applyCancel({required ApplyCancelRequest applyCancelRequest});
}
