import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';

class NoticeResponse {
  final int post_id; // 공지사항 ID 필드
  final String title;
  final String writing; // 작성 날짜
  final String? content; // 세부 내용 (Optional)

  NoticeResponse({
    required this.post_id,
    required this.title,
    required this.writing,
    this.content,
  });

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    return NoticeResponse(
      post_id: int.parse(json['post_id']), // 문자열 ID를 정수로 변환
      title: json['title'],
      writing: json['writing'],
      content: json['content'], // getNoticeDetail에서 사용할 수 있음
    );
  }

  NoticeEntity toEntity() {
    return NoticeEntity(
      noticeId: post_id,
      title: title,
      writing: writing,
      content: content,
    );
  }
}
