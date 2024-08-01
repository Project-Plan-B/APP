import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:plan_b/src/data/notice/dto/response/notice_response.dart';
import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';

class RemoteNoticeDataSource {
  Future<List<NoticeEntity>> getNotice() async {
    final response = await http.get(Uri.parse("12345678910/notice"));
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    return (jsonDecode(utf8.decode(response.bodyBytes)) as List<dynamic>)
        .map((i) => NoticeResponse.fromJson(i).toEntity())
        .toList();
  }
}
