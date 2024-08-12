import 'package:plan_b/src/domain/study/repository/study_repository.dart';

class UpdateLaundryRoomIndexUseCase {
  final LaundryRepository _laundryRepository;

  const UpdateLaundryRoomIndexUseCase(
      {required LaundryRepository laundryRepository})
      : _laundryRepository = laundryRepository;

  Future<void> execute({required int value}) =>
      _laundryRepository.setValue(key: 'laundryRoomIndex', value: value);
}
