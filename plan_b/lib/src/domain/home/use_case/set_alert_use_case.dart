import 'package:plan_b/src/data/home/dto/request/set_alert_request.dart';
import 'package:plan_b/src/data/home/dto/response/set_alert_response.dart';
import 'package:plan_b/src/domain/home/repository/home_repository.dart';

class SetAlertUseCase {
  final ApplyRepository repository;

  SetAlertUseCase(this.repository);

  Future<SetAlertResponse> execute(SetAlertRequest request) async {
    return await repository.setAlert(request);
  }
}
