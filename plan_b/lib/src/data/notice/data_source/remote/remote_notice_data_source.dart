import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan_b/src/data/notice/dto/response/notice_response.dart';
import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';

class RemoteNoticeDataSource {
  Future<List<NoticeEntity>> getNotices() async {
    final response = await http.get(Uri.parse("http://192.168.54.52:8080/list/show/all"));

    if (response.statusCode != 200) {
      throw Exception('Failed to load notices');
    }

    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    // `NoticeResponse`로 변환하고, 다시 `NoticeEntity`로 변환
    return data.map((json) => NoticeResponse.fromJson(json).toEntity()).toList();
  }

  Future<String> getNoticeDetail(int id) async {
    final response = await http.get(Uri.parse("http://192.168.54.52:8080/list/show/$id"));

    if (response.statusCode != 200) {
      throw Exception('Failed to load notice detail');
    }

    final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    // 공지사항의 내용만 반환
    return data['content'] as String;
  }
}
