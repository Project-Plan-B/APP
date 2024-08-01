import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:plan_b/src/data/home/dto/request/home_cancel_request.dart';
import 'package:plan_b/src/data/home/dto/response/home_response.dart';
import 'package:plan_b/src/domain/home/entity/home_entity.dart';

class RemoteApplyDataSource {
  Future<String> _getToken() async =>
      await FirebaseMessaging.instance.getToken() ?? "whatThe";

  Future<List<ApplyEntity>> getApplyList() async {
    final response = await http.post(Uri.parse("123456/push_list"),
        body: {"token": await _getToken()});
    if (response.statusCode != 200) throw Exception(response.body);
    return (jsonDecode(response.body) as List<dynamic>)
        .map((i) => ApplyResponse.fromJson(i).toEntity())
        .toList();
  }

  Future<void> applyCancel(
      {required ApplyCancelRequest applyCancelRequest}) async {
    applyCancelRequest.token = await _getToken();
    final response = await http.post(Uri.parse("123456/push_cancel"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(applyCancelRequest.toJson()));
    if (response.statusCode != 200) throw Exception(response.body);
  }
}
