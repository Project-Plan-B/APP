import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';
import 'package:plan_b/src/domain/notice/repository/notice_repository.dart';

class UpdateLastNoticeIdUseCase {
  final NoticeRepository _noticeRepository;

  UpdateLastNoticeIdUseCase({required NoticeRepository noticeRepository})
      : _noticeRepository = noticeRepository;

  Future<void> execute({required List<NoticeEntity> noticeList}) =>
      _noticeRepository.setLastNoticeId(
          key: "lastNoticeId",
          value: noticeList.isEmpty ? -1 : noticeList.first.noticeId);
}
