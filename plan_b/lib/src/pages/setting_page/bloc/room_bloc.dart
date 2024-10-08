import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/domain/study/use_case/get_study_room_index_use_case.dart';
import 'package:plan_b/src/domain/study/use_case/update_study_room_index_use_case.dart';
import 'package:plan_b/main.dart';
import 'package:plan_b/src/pages/setting_page/bloc/laundry_room_model.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_event.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState<LaundryRoomModel>> {
  final GetLaundryRoomIndexUseCase _getLaundryRoomIndexUseCase;
  final UpdateLaundryRoomIndexUseCase _updateLaundryRoomIndexUseCase;

  RoomBloc(
      {required GetLaundryRoomIndexUseCase getLaundryRoomIndexUseCase,
      required UpdateLaundryRoomIndexUseCase updateLaundryRoomIndexUseCase})
      : _getLaundryRoomIndexUseCase = getLaundryRoomIndexUseCase,
        _updateLaundryRoomIndexUseCase = updateLaundryRoomIndexUseCase,
        super(Initial(
            data: const LaundryRoomModel(
                roomLocation: RoomLocation.schoolSide,
                laundryRoomLayer: LaundryRoomLayer.first,
                isClick: false,
                isNFCShowBottomSheet: false,
                showingBottomSheet: false))) {
    on<UpdateRoomIndexEvent>(_updateRoomIndexEventHandler);
    on<GetRoomIndexEvent>(_getRoomIndexEventHandler);
    on<ModifyRoomIndexEvent>(_modifyRoomIndexEventHandler);
    on<ModifyLaundryRoomLayerEvent>(_modifyPlaceIconIndexEventHandler);
    on<ShowBottomSheetEvent>(_showBottomSheetEventHandler);
    on<InitialShowBottomSheetEvent>(_initialShowBottomSheetEventHandler);
    on<ShowingBottomSheetEvent>(_showingBottomSheetEventHandler);
    on<ClosingBottomSheetEvent>(_closingBottomSheetEventHandler);
  }

  void _updateRoomIndexEventHandler(
      UpdateRoomIndexEvent event, Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(data: state.value.copyWith(roomLocation: event.roomLocation)));
    _updateLaundryRoomIndexUseCase.execute(value: event.roomLocation.index);
  }

  void _getRoomIndexEventHandler(
      GetRoomIndexEvent event, Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(
        data: state.value.copyWith(
            roomLocation: RoomLocation.values
                .elementAt(_getLaundryRoomIndexUseCase.execute))));
  }

  void _modifyRoomIndexEventHandler(
      ModifyRoomIndexEvent event, Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(data: state.value.copyWith(roomLocation: event.roomLocation)));
  }

  void _modifyPlaceIconIndexEventHandler(ModifyLaundryRoomLayerEvent event,
      Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(
        data: state.value.copyWith(laundryRoomLayer: event.laundryRoomLayer)));
  }

  void _showBottomSheetEventHandler(
      ShowBottomSheetEvent event, Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(data: state.value.copyWith(isNFCShowBottomSheet: true)));
  }

  void _initialShowBottomSheetEventHandler(InitialShowBottomSheetEvent event,
      Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(data: state.value.copyWith(isNFCShowBottomSheet: false)));
  }

  void _showingBottomSheetEventHandler(ShowingBottomSheetEvent event,
      Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(data: state.value.copyWith(showingBottomSheet: true)));
  }

  void _closingBottomSheetEventHandler(ClosingBottomSheetEvent event,
      Emitter<RoomState<LaundryRoomModel>> emit) {
    emit(Changed(data: state.value.copyWith(showingBottomSheet: false)));
  }
}
