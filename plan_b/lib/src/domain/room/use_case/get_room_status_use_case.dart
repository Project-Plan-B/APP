import 'package:plan_b/src/domain/room/entity/room_entity.dart';
import 'package:plan_b/src/domain/room/repository/room_repository.dart';

class GetLaundryStatusUseCase {
  final LaundryRepository _laundryRepository;

  GetLaundryStatusUseCase({required LaundryRepository laundryRepository})
      : _laundryRepository = laundryRepository;

  Stream<LaundryEntity> get laundryList => _laundryRepository.laundryList;

  void execute() {
    _laundryRepository.webSocketInit();
  }
}
