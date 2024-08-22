import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';
import 'package:plan_b/src/domain/notice/use_case/get_last_notice_id_use_case.dart';
import 'package:plan_b/src/domain/notice/use_case/get_notice_use_case.dart';
import 'package:plan_b/src/domain/notice/use_case/update_last_notice_id_use_case.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_event.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_model.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState<NoticeModel>> {
  final GetNoticeUseCase _getNoticeUseCase;
  final GetLastNoticeIdUseCase _getLastNoticeIdUseCase;
  final UpdateLastNoticeIdUseCase _updateLastNoticeIdUseCase;

  NoticeBloc({
    required GetNoticeUseCase getNoticeUseCase,
    required GetLastNoticeIdUseCase getLastNoticeIdUseCase,
    required UpdateLastNoticeIdUseCase updateLastNoticeIdUseCase,
  })  : _getNoticeUseCase = getNoticeUseCase,
        _getLastNoticeIdUseCase = getLastNoticeIdUseCase,
        _updateLastNoticeIdUseCase = updateLastNoticeIdUseCase,
        super(Empty(
        data: const NoticeModel(
          noticeList: <NoticeEntity>[],
          isNewNotice: false,
        ),
      )) {
    on<GetNoticeEvent>(_getNoticeEventHandler);
    on<UpdateLastNoticeIdEvent>(_updateLastNoticeIdEventHandler);
    on<GetNoticeDetailEvent>(_getNoticeDetailEventHandler);
  }

  void _getNoticeEventHandler(
      GetNoticeEvent event, Emitter<NoticeState<NoticeModel>> emit) async {
    try {
      emit(Loading());
      final noticeList = await _getNoticeUseCase.execute();
      final isNewNotice = _getLastNoticeIdUseCase.execute(noticeList: noticeList);
      final newNoticeModel =
      NoticeModel(noticeList: noticeList, isNewNotice: isNewNotice);
      emit(Loaded(data: newNoticeModel));
    } catch (e) {
      emit(Error(error: e));
    }
  }

  void _updateLastNoticeIdEventHandler(UpdateLastNoticeIdEvent event,
      Emitter<NoticeState<NoticeModel>> emit) async {
    try {
      await _updateLastNoticeIdUseCase.execute(
          noticeList: state.value.noticeList);
      emit(Loaded(data: state.value.copyWith(isNewNotice: false)));
    } catch (e) {
      emit(Error(error: e));
    }
  }

  void _getNoticeDetailEventHandler(GetNoticeDetailEvent event,
      Emitter<NoticeState<NoticeModel>> emit) async {
    try {
      print('Fetching notice detail for ID: ${event.noticeId}');

      // Loading 상태로 재진입하지 않도록 기존 emit(Loading()); 제거
      final content = await _getNoticeUseCase.getNoticeDetail(event.noticeId);

      // Null 체크
      if (content == null) {
        throw Exception('Content is null');
      }

      final updatedList = state.value.noticeList.map((notice) {
        if (notice.noticeId == event.noticeId) {
          return notice.copyWith(content: content);
        }
        return notice;
      }).toList();

      emit(Loaded(data: state.value.copyWith(noticeList: updatedList)));
    } catch (e) {
      print('Error fetching notice detail: $e');
      emit(Error(error: e.toString()));
    }
  }
}
