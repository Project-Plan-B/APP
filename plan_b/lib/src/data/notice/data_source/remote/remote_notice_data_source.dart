import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan_b/src/data/notice/dto/response/notice_response.dart';
import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';

class RemoteNoticeDataSource {
  Future<List<NoticeEntity>> getNotices() async {
    final response = await http.get(Uri.parse("https://019e4e50-79e8-48c6-9924-619988781875.mock.pstmn.io/list/show_all"));

    if (response.statusCode != 200) {
      throw Exception('Failed to load notices');
    }

    final Map<String, dynamic> json = jsonDecode(utf8.decode(response.bodyBytes));
    final List<dynamic> data = json['list']; // "list" 키에서 데이터를 가져옴

    // `NoticeResponse`로 변환하고, 다시 `NoticeEntity`로 변환
    return data.map((json) => NoticeResponse.fromJson(json).toEntity()).toList();
  }

  Future<String> getNoticeDetail(int id) async {
    final response = await http.get(Uri.parse("https://019e4e50-79e8-48c6-9924-619988781875.mock.pstmn.io/list/show/$id"));

    if (response.statusCode != 200) {
      throw Exception('Failed to load notice detail');
    }

    final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
    print('Received data: $data');

    return data['content'] as String;
  }
}
