import 'dart:async';

import 'package:plan_b/src/data/study/data_source/local/local_study_data_source.dart';
import 'package:plan_b/src/data/study/data_source/remote/remote_study_data_source.dart';
import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/domain/study/repository/study_repository.dart';

class LaundryRepositoryImpl implements LaundryRepository {
  final LocalLaundryDataSource _localLaundryDataSource;
  final RemoteLaundryDataSource _remoteLaundryDataSource;

  LaundryRepositoryImpl(
      {required LocalLaundryDataSource localLaundryDataSource,
      required RemoteLaundryDataSource remoteLaundryDataSource})
      : _localLaundryDataSource = localLaundryDataSource,
        _remoteLaundryDataSource = remoteLaundryDataSource;

  @override
  Stream<LaundryEntity> get laundryList =>
      _remoteLaundryDataSource.laundryList.asBroadcastStream();

  @override
  int? getValue({required String key}) =>
      _localLaundryDataSource.getValue(key: key);

  @override
  Future<void> setValue({required String key, required int value}) =>
      _localLaundryDataSource.setValue(key: key, value: value);

  @override
  Future<List<LaundryEntity>> getAllLaundryList() =>
      _remoteLaundryDataSource.getAllLaundryList();
}
