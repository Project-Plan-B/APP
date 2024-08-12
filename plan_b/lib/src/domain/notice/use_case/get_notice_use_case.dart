import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';
import 'package:plan_b/src/domain/notice/repository/notice_repository.dart';

class GetNoticeUseCase {
  final NoticeRepository _noticeRepository;

  GetNoticeUseCase({required NoticeRepository noticeRepository})
      : _noticeRepository = noticeRepository;

  Future<List<NoticeEntity>> execute() => _noticeRepository.getNotices();
}