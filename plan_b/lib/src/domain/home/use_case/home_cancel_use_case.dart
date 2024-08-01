import 'package:plan_b/src/data/home/dto/request/home_cancel_request.dart';
import 'package:plan_b/src/domain/home/repository/home_repository.dart';

class ApplyCancelUseCase {
  final ApplyRepository _applyRepository;

  ApplyCancelUseCase({required ApplyRepository applyRepository})
      : _applyRepository = applyRepository;

  Future<void> execute({required ApplyCancelRequest applyCancelRequest}) =>
      _applyRepository.applyCancel(applyCancelRequest: applyCancelRequest);
}
