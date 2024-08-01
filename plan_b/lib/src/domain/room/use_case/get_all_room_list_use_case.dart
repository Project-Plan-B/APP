import 'package:plan_b/src/domain/room/entity/room_entity.dart';
import 'package:plan_b/src/domain/room/repository/room_repository.dart';

class GetAllLaundryListUseCase {
  final LaundryRepository _laundryRepository;

  GetAllLaundryListUseCase({required LaundryRepository laundryRepository})
      : _laundryRepository = laundryRepository;

  Future<List<LaundryEntity>> execute() =>
      _laundryRepository.getAllLaundryList();
}
