import 'dart:async';
import 'package:plan_b/src/data/home/data_source/remote/remote_home_data_source.dart';
import 'package:plan_b/src/domain/home/repository/home_repository.dart';
import 'package:plan_b/src/data/home/dto/request/set_alert_request.dart';
import 'package:plan_b/src/data/home/dto/response/set_alert_response.dart';

class ApplyRepositoryImpl implements ApplyRepository {
  final RemoteApplyDataSource _remoteApplyDataSource;

  ApplyRepositoryImpl({required RemoteApplyDataSource remoteApplyDataSource})
      : _remoteApplyDataSource = remoteApplyDataSource;

  @override
  Future<SetAlertResponse> setAlert(SetAlertRequest request) async {
    return await _remoteApplyDataSource.setConfusionAlert(
      roomId: request.roomId,
      confusionLevel: request.confusionLevel,
    );
  }
}
