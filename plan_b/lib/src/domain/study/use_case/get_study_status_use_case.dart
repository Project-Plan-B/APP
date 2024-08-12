import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/domain/study/repository/study_repository.dart';

class GetLaundryStatusUseCase {
  final LaundryRepository _laundryRepository;

  GetLaundryStatusUseCase({required LaundryRepository laundryRepository})
      : _laundryRepository = laundryRepository;

  Stream<LaundryEntity> get laundryList => _laundryRepository.laundryList;
}
