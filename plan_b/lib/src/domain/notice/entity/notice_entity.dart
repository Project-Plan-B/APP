class NoticeEntity {
  final int noticeId; // 공지사항 ID 필드 추가
  final String title;
  final String writing;
  final String? content; // 세부 내용을 위한 필드 (Optional)

  NoticeEntity({
    required this.noticeId, // 필수 필드로 설정
    required this.title,
    required this.writing,
    this.content,
  });

  // copyWith 메서드 추가
  NoticeEntity copyWith({
    int? noticeId,
    String? title,
    String? writing,
    String? content,
  }) {
    return NoticeEntity(
      noticeId: noticeId ?? this.noticeId,
      title: title ?? this.title,
      writing: writing ?? this.writing,
      content: content ?? this.content,
    );
  }
}
