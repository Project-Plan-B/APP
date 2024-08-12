import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plan_b/src/data/study/dto/response/study_response.dart';
import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RemoteLaundryDataSource {
  final StreamController<LaundryEntity> _streamController;

  RemoteLaundryDataSource(
      {required StreamController<LaundryEntity> streamController})
      : _streamController = streamController;

  Stream<LaundryEntity> get laundryList =>
      _streamController.stream.asBroadcastStream();


  Future<List<LaundryEntity>> getAllLaundryList() async {
    final response = await http.get(Uri.parse("http://192.168.54.52:8080/device_list_boy"));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return (jsonDecode(response.body) as List<dynamic>)
        .map((i) => LaundryResponse.fromJson(i).toEntity())
        .toList();
  }
}

