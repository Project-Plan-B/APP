import 'dart:async';

import 'package:plan_b/src/data/home/data_source/remote/remote_home_data_source.dart';
import 'package:plan_b/src/data/home/dto/request/home_cancel_request.dart';
import 'package:plan_b/src/domain/home/entity/home_entity.dart';
import 'package:plan_b/src/domain/home/repository/home_repository.dart';

class ApplyRepositoryImpl implements ApplyRepository {
  final RemoteApplyDataSource _remoteApplyDataSource;

  ApplyRepositoryImpl({required RemoteApplyDataSource remoteApplyDataSource})
      : _remoteApplyDataSource = remoteApplyDataSource;

  @override
  Future<List<ApplyEntity>> getApplyList() =>
      _remoteApplyDataSource.getApplyList();

  @override
  Future<void> applyCancel({required ApplyCancelRequest applyCancelRequest}) =>
      _remoteApplyDataSource.applyCancel(
          applyCancelRequest: applyCancelRequest);
}
