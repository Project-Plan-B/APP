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
}
