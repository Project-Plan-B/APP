import 'package:plan_b/src/domain/room/repository/room_repository.dart';

class GetLaundryRoomIndexUseCase {
  final LaundryRepository _laundryRepository;

  const GetLaundryRoomIndexUseCase(
      {required LaundryRepository laundryRepository})
      : _laundryRepository = laundryRepository;

  int get execute => _laundryRepository.getValue(key: "laundryRoomIndex") ?? 0;
}
