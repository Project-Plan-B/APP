import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/domain/study/repository/study_repository.dart';

class GetAllLaundryListUseCase {
  final LaundryRepository _laundryRepository;

  GetAllLaundryListUseCase({required LaundryRepository laundryRepository})
      : _laundryRepository = laundryRepository;

  Future<List<LaundryEntity>> execute() =>
      _laundryRepository.getAllLaundryList();
}
