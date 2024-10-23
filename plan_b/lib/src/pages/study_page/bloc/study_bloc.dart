import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/domain/study/use_case/get_all_study_list_use_case.dart';
import 'package:plan_b/src/domain/study/use_case/get_study_status_use_case.dart';
import 'package:plan_b/src/pages/study_page/bloc/study_event.dart';
import 'package:plan_b/src/pages/study_page/bloc/study_model.dart';
import 'package:plan_b/src/pages/study_page/bloc/study_state.dart';

class LaundryBloc extends Bloc<LaundryEvent, LaundryState<LaundryModel>> {
  final GetLaundryStatusUseCase _getLaundryStatusUseCase;
  final GetAllLaundryListUseCase _getAllLaundryListEventUseCase;

  LaundryBloc(
      {required GetLaundryStatusUseCase getLaundryStatusUseCase,
      required GetAllLaundryListUseCase getAllLaundryListUseCase})
      : _getLaundryStatusUseCase = getLaundryStatusUseCase,
        _getAllLaundryListEventUseCase = getAllLaundryListUseCase,
        super(Empty()) {
    on<GetLaundryEvent>(_getLaundryEventHandler);
    on<GetAllLaundryListEvent>(_getAllLaundryListEventHandler);
  }

  void _getLaundryEventHandler(
      GetLaundryEvent event, Emitter<LaundryState<LaundryModel>> emit) async {
    try {
      await for (var data in _getLaundryStatusUseCase.laundryList) {
        final newLaundryModel = LaundryModel(
            laundryList: state.value.laundryList
                .map((e) => e.id == data.id
                    ? LaundryEntity(
                        id: e.id,
                        state: data.state,
                        roomName: data.roomName)
                    : e)
                .toList());
        emit(Loaded(data: newLaundryModel));
      }
    } catch (e) {
      emit(Error(error: e));
    }
  }

  void _getAllLaundryListEventHandler(GetAllLaundryListEvent event,
      Emitter<LaundryState<LaundryModel>> emit) async {
    try {
      emit(Loading());
      final newState = await _getAllLaundryListEventUseCase.execute();
      final newLaundryModel = LaundryModel(laundryList: newState);
      emit(Loaded(data: newLaundryModel));
    } catch (e) {
      emit(Error(error: e));
    }
  }
}
