import 'package:plan_b/src/domain/home/entity/home_entity.dart';
import 'package:plan_b/src/domain/home/repository/home_repository.dart';

class GetApplyListUseCase {
  final ApplyRepository _applyRepository;

  GetApplyListUseCase({required ApplyRepository applyRepository})
      : _applyRepository = applyRepository;

  Future<List<ApplyEntity>> execute() => _applyRepository.getApplyList();
}
