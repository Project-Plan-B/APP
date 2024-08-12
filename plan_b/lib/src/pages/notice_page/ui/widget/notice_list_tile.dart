import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticeListTile extends StatefulWidget {
  final NoticeEntity noticeEntity;

  const NoticeListTile({super.key, required this.noticeEntity});

  @override
  State<NoticeListTile> createState() => _NoticeListTileState();
}

class _NoticeListTileState extends State<NoticeListTile> {
  bool _tap = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _tap = !_tap),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.5.h),
        padding: EdgeInsets.all(20.0.r),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.noticeEntity.title,
                        maxLines: 4,
                        style: TextStyle(fontSize: 16.0.sp),
                      ),
                      Text(
                        widget.noticeEntity.writing, // 'date'를 'writing'으로 변경
                        maxLines: 2,
                        style: TextStyle(fontSize: 10.0.sp),
                      ),
                    ],
                  ),
                ),
                Icon(
                  _tap ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                ),
              ],
            ),
            _tap
                ? Markdown(
              padding: EdgeInsets.only(top: 10.0.r),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              data: widget.noticeEntity.content ?? '', // 'contents'를 'content'로 변경
              onTapLink: (text, href, title) async {
                if (href != null) {
                  await launchUrl(
                    Uri.parse(href),
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
              styleSheet: MarkdownStyleSheet(
                a: const TextStyle(color: Colors.blue),
              ),
            )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
