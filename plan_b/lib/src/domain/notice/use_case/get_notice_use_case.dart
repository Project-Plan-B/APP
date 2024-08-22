import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';
import 'package:plan_b/src/domain/notice/repository/notice_repository.dart';

class GetNoticeUseCase {
  final NoticeRepository _noticeRepository;

  GetNoticeUseCase({required NoticeRepository noticeRepository})
      : _noticeRepository = noticeRepository;

  Future<List<NoticeEntity>> execute() => _noticeRepository.getNotices();

  // 여기에 getNoticeDetail 메서드를 추가합니다.
  Future<String?> getNoticeDetail(int id) => _noticeRepository.getNoticeDetail(id);
}
