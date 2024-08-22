import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:plan_b/src/data/home/data_source/remote/remote_home_data_source.dart';
import 'package:plan_b/src/data/home/repository/home_repository_impl.dart';
import 'package:plan_b/src/data/study/data_source/local/local_study_data_source.dart';
import 'package:plan_b/src/data/study/data_source/remote/remote_study_data_source.dart';
import 'package:plan_b/src/data/study/repository/study_repository_impl.dart';
import 'package:plan_b/src/data/notice/data_source/local/local_notice_data_source.dart';
import 'package:plan_b/src/data/notice/data_source/remote/remote_notice_data_source.dart';
import 'package:plan_b/src/data/notice/repository/notice_repository_impl.dart';
import 'package:plan_b/src/domain/home/repository/home_repository.dart';
import 'package:plan_b/src/domain/home/use_case/set_alert_use_case.dart';
import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/domain/study/repository/study_repository.dart';
import 'package:plan_b/src/domain/study/use_case/get_all_study_list_use_case.dart';
import 'package:plan_b/src/domain/study/use_case/get_study_room_index_use_case.dart';
import 'package:plan_b/src/domain/study/use_case/get_study_status_use_case.dart';
import 'package:plan_b/src/domain/study/use_case/update_study_room_index_use_case.dart';
import 'package:plan_b/src/domain/notice/repository/notice_repository.dart';
import 'package:plan_b/src/domain/notice/use_case/get_last_notice_id_use_case.dart';
import 'package:plan_b/src/domain/notice/use_case/get_notice_use_case.dart';
import 'package:plan_b/src/domain/notice/use_case/update_last_notice_id_use_case.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_bloc.dart';
import 'package:plan_b/src/pages/study_page/bloc/study_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_bloc.dart';

Future<List<BlocProvider>> di() async {
  final box = await Hive.openBox<int>("PLANB");

  LocalLaundryDataSource localLaundryDataSource =
  LocalLaundryDataSource(localDatabase: box);

  LocalNoticeDataSource localNoticeDataSource = LocalNoticeDataSource(box: box);

  RemoteLaundryDataSource remoteLaundryDataSource = RemoteLaundryDataSource(
      streamController: StreamController<LaundryEntity>.broadcast());

  RemoteApplyDataSource remoteApplyDataSource = RemoteApplyDataSource();

  RemoteNoticeDataSource remoteNoticeDataSource = RemoteNoticeDataSource();

  LaundryRepository laundryRepository = LaundryRepositoryImpl(
      localLaundryDataSource: localLaundryDataSource,
      remoteLaundryDataSource: remoteLaundryDataSource);

  ApplyRepository applyRepository = ApplyRepositoryImpl(
    remoteApplyDataSource: remoteApplyDataSource,
  );

  NoticeRepository noticeRepository = NoticeRepositoryImpl(
      remoteNoticeDataSource: remoteNoticeDataSource,
      localNoticeDataSource: localNoticeDataSource);

  GetLaundryStatusUseCase getLaundryStatusUseCase =
  GetLaundryStatusUseCase(laundryRepository: laundryRepository);

  SetAlertUseCase setAlertUseCase = SetAlertUseCase(applyRepository);

  GetLaundryRoomIndexUseCase getLaundryRoomIndexUseCase =
  GetLaundryRoomIndexUseCase(laundryRepository: laundryRepository);

  GetAllLaundryListUseCase getAllLaundryListUseCase =
  GetAllLaundryListUseCase(laundryRepository: laundryRepository);

  UpdateLaundryRoomIndexUseCase updateLaundryRoomIndexUseCase =
  UpdateLaundryRoomIndexUseCase(laundryRepository: laundryRepository);

  GetNoticeUseCase getNoticeUseCase =
  GetNoticeUseCase(noticeRepository: noticeRepository);

  GetLastNoticeIdUseCase getLastNoticeIdUseCase =
  GetLastNoticeIdUseCase(noticeRepository: noticeRepository);

  UpdateLastNoticeIdUseCase updateLastNoticeIdUseCase =
  UpdateLastNoticeIdUseCase(noticeRepository: noticeRepository);

  return [
    BlocProvider<ApplyBloc>(
        create: (context) => ApplyBloc(
          setAlertUseCase: setAlertUseCase,)),
    BlocProvider<LaundryBloc>(
        create: (context) => LaundryBloc(
            getLaundryStatusUseCase: getLaundryStatusUseCase,
            getAllLaundryListUseCase: getAllLaundryListUseCase)),
    BlocProvider<RoomBloc>(
      create: (context) => RoomBloc(
          getLaundryRoomIndexUseCase: getLaundryRoomIndexUseCase,
          updateLaundryRoomIndexUseCase: updateLaundryRoomIndexUseCase),
    ),
    BlocProvider<NoticeBloc>(
      create: (context) => NoticeBloc(
        getNoticeUseCase: getNoticeUseCase,
        getLastNoticeIdUseCase: getLastNoticeIdUseCase,
        updateLastNoticeIdUseCase: updateLastNoticeIdUseCase,
      ),
    ),
  ];
}
