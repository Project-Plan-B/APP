import 'package:plan_b/src/data/home/dto/request/set_alert_request.dart';
import 'package:plan_b/src/data/home/dto/response/set_alert_response.dart';
import 'package:plan_b/src/domain/home/entity/home_entity.dart';

abstract class ApplyRepository {
  Future<SetAlertResponse> setAlert(SetAlertRequest request);
}
