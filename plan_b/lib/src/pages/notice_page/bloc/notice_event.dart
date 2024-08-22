abstract class NoticeEvent {}

class GetNoticeEvent extends NoticeEvent {}

class UpdateLastNoticeIdEvent extends NoticeEvent {}

class GetNoticeDetailEvent extends NoticeEvent {
  final int noticeId;

  GetNoticeDetailEvent({required this.noticeId});
}
