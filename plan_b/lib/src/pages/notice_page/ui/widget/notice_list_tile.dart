// lib/src/pages/notice_page/ui/widget/notice_list_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/src/domain/notice/entity/notice_entity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_state.dart';

import '../../bloc/notice_event.dart';
import '../../bloc/notice_model.dart';

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
    return BlocBuilder<NoticeBloc, NoticeState<NoticeModel>>(
      builder: (context, state) {
        final noticeEntity = state.value.noticeList
            .firstWhere((notice) => notice.noticeId == widget.noticeEntity.noticeId, orElse: () => widget.noticeEntity);

        return GestureDetector(
          onTap: () {
            setState(() {
              _tap = !_tap;
            });
            if (_tap && widget.noticeEntity.content == null) {
              BlocProvider.of<NoticeBloc>(context).add(GetNoticeDetailEvent(noticeId: widget.noticeEntity.noticeId));
            }
          },
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
                            noticeEntity.title,
                            maxLines: 4,
                            style: TextStyle(
                                fontSize: 16.0.sp,
                              fontFamily: "NotoSansKR",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            noticeEntity.writing,
                            maxLines: 2,
                            style: TextStyle(fontSize: 10.0.sp,
                              fontFamily: "NotoSansKR",
                              fontWeight: FontWeight.w400,
                            ),
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
                    ? noticeEntity.content != null
                    ? Markdown(
                  padding: EdgeInsets.only(top: 10.0.r),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  data: noticeEntity.content!,
                  onTapLink: (text, href, title) async {
                    if (href != null) {
                      await launchUrl(Uri.parse(href!),
                          mode: LaunchMode.externalApplication);
                    }
                  },
                  styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
                )
                    : const Center(child: CircularProgressIndicator())
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
