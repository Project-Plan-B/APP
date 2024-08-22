import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';

abstract class NoticeRepository {
  Future<List<NoticeEntity>> getNotices();

  Future<String?> getNoticeDetail(int id);

  int? getLastNoticeId({required String key});

  Future<void> setLastNoticeId({required String key, required int value});
}
