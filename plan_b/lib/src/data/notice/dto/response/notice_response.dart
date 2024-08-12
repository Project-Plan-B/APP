import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';

class NoticeResponse {
  final int noticeId; // 공지사항 ID 필드
  final String title;
  final String writing; // 작성 날짜
  final String? content; // 세부 내용 (Optional)

  NoticeResponse({
    required this.noticeId,
    required this.title,
    required this.writing,
    this.content,
  });

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    return NoticeResponse(
      noticeId: json['noticeId'],
      title: json['title'],
      writing: json['writing'],
      content: json['content'],
    );
  }

  NoticeEntity toEntity() {
    return NoticeEntity(
      noticeId: noticeId,
      title: title,
      writing: writing,
      content: content,
    );
  }
}
