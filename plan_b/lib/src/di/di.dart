import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:plan_b/src/data/home/data_source/remote/remote_home_data_source.dart';
import 'package:plan_b/src/data/home/repository/home_repository_impl.dart';
import 'package:plan_b/src/data/notice/data_source/local/local_notice_data_source.dart';
import 'package:plan_b/src/data/notice/data_source/remote/remote_notice_data_source.dart';
import 'package:plan_b/src/data/notice/repository/notice_repository_impl.dart';
import 'package:plan_b/src/domain/home/repository/home_repository.dart';
import 'package:plan_b/src/domain/home/use_case/home_cancel_use_case.dart';
import 'package:plan_b/src/domain/home/use_case/get_home_list_use_case.dart';
import 'package:plan_b/src/domain/notice/repository/notice_repository.dart';
import 'package:plan_b/src/domain/notice/use_case/get_last_notice_id_use_case.dart';
import 'package:plan_b/src/domain/notice/use_case/get_notice_use_case.dart';
import 'package:plan_b/src/domain/notice/use_case/update_last_notice_id_use_case.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';

Future<List<BlocProvider>> di() async {
  final box = await Hive.openBox<int>("Lotura");

  LocalNoticeDataSource localNoticeDataSource = LocalNoticeDataSource(box: box);

  RemoteApplyDataSource remoteApplyDataSource = RemoteApplyDataSource();

  RemoteNoticeDataSource remoteNoticeDataSource = RemoteNoticeDataSource();

  ApplyRepository applyRepository =
  ApplyRepositoryImpl(remoteApplyDataSource: remoteApplyDataSource);

  NoticeRepository noticeRepository = NoticeRepositoryImpl(
      remoteNoticeDataSource: remoteNoticeDataSource,
      localNoticeDataSource: localNoticeDataSource);

  GetApplyListUseCase getApplyListUseCase =
  GetApplyListUseCase(applyRepository: applyRepository);

  ApplyCancelUseCase applyCancelUseCase =
  ApplyCancelUseCase(applyRepository: applyRepository);

  GetNoticeUseCase getNoticeUseCase =
  GetNoticeUseCase(noticeRepository: noticeRepository);

  GetLastNoticeIdUseCase getLastNoticeIdUseCase =
  GetLastNoticeIdUseCase(noticeRepository: noticeRepository);

  UpdateLastNoticeIdUseCase updateLastNoticeIdUseCase =
  UpdateLastNoticeIdUseCase(noticeRepository: noticeRepository);

  return [
    BlocProvider<ApplyBloc>(
        create: (context) => ApplyBloc(
            getApplyListUseCase: getApplyListUseCase,
            applyCancelUseCase: applyCancelUseCase,)),

    BlocProvider<NoticeBloc>(
      create: (context) => NoticeBloc(
        getNoticeUseCase: getNoticeUseCase,
        getLastNoticeIdUseCase: getLastNoticeIdUseCase,
        updateLastNoticeIdUseCase: updateLastNoticeIdUseCase,
      ),
    ),
  ];
}
