import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/data/home/dto/request/home_cancel_request.dart';
import 'package:plan_b/src/domain/home/entity/home_entity.dart';
import 'package:plan_b/src/domain/home/use_case/home_cancel_use_case.dart';
import 'package:plan_b/src/domain/home/use_case/get_home_list_use_case.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_event.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_model.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState<ApplyModel>> {
  final GetApplyListUseCase _getApplyListUseCase;
  final ApplyCancelUseCase _applyCancelUseCase;

  ApplyBloc(
      {required GetApplyListUseCase getApplyListUseCase,
      required ApplyCancelUseCase applyCancelUseCase})
      : _getApplyListUseCase = getApplyListUseCase,
        _applyCancelUseCase = applyCancelUseCase,
        super(Empty()) {
    on<GetApplyListEvent>(_getApplyListEventHandler);
    on<ApplyCancelEvent>(_applyCancelEventHandler);
  }

  void _getApplyListEventHandler(
      GetApplyListEvent event, Emitter<ApplyState<ApplyModel>> emit) async {
    try {
      emit(Loading());
      final applyList = await _getApplyListUseCase.execute();
      final applyModel = ApplyModel(applyList: applyList);
      emit((Loaded(data: applyModel)));
    } catch (e) {
      emit(Error(errorMessage: e));
    }
  }

  void _applyCancelEventHandler(
      ApplyCancelEvent event, Emitter<ApplyState<ApplyModel>> emit) async {
    try {
      List<ApplyEntity> newApplyList = state.value.applyList;
      emit(Loading());
      await _applyCancelUseCase.execute(
          applyCancelRequest: ApplyCancelRequest(deviceId: event.deviceId));
      newApplyList.removeWhere((e) => e.deviceId == event.deviceId);
      final applyModel = ApplyModel(applyList: newApplyList);
      emit(Loaded(data: applyModel));
    } catch (e) {
      emit(Error(errorMessage: e));
    }
  }
}
