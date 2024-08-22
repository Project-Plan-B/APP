import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/data/home/dto/request/set_alert_request.dart';
import 'package:plan_b/src/domain/home/use_case/set_alert_use_case.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_event.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_model.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_state.dart';

class ApplyBloc extends Bloc<ApplyEvent, ApplyState<ApplyModel>> {
  final SetAlertUseCase _setAlertUseCase;

  ApplyBloc({
    required SetAlertUseCase setAlertUseCase,
  })  :_setAlertUseCase = setAlertUseCase,
        super(Empty()) {
    on<SetConfusionEvent>(_setConfusionEventHandler);
  }


  void _setConfusionEventHandler(
      SetConfusionEvent event, Emitter<ApplyState<ApplyModel>> emit) async {
    try {
      emit(Loading());
      final response = await _setAlertUseCase.execute(SetAlertRequest(
        roomId: event.roomId,
        confusionLevel: event.confusionLevel,
      ));
      if (response.success) {
        emit(Loaded(data: state.value));
      } else {
        emit(Error(errorMessage: response.message));
      }
    } catch (e) {
      emit(Error(errorMessage: e.toString()));
    }
  }
}
