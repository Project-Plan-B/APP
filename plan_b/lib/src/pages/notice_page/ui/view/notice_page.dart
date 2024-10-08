import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_model.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_state.dart';
import 'package:plan_b/src/pages/notice_page/ui/widget/notice_list_tile.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F0),
      appBar: AppBar(
        backgroundColor: Color(0xFFF1F3F0),
        elevation: 0.0,
        toolbarHeight: 90.0.r,
        leading: IconButton(
          padding: EdgeInsets.only(left: 24.0.r),
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.black,
            size: 30.0.r,
          ),
        ),
        title: Text(
          "공지",
          style: TextStyle(
            fontSize: 24.0.sp,
            color: Colors.black,
            fontFamily: "NotoSansKR",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.r),
        child: BlocBuilder<NoticeBloc, NoticeState<NoticeModel>>(
          builder: (context, state) => switch (state) {
            Empty() => const Center(child: Text("비어있음")),
            Loading() => const Center(child: CircularProgressIndicator()),
            Error() => const Center(child: Text("인터넷 연결을 확인해주세요")),
            Loaded(data: final data) => SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 12.0.r),
                itemCount: data.noticeList.length,
                itemBuilder: (context, index) {
                  return NoticeListTile(noticeEntity: data.noticeList[index]);
                },
              ),
            ),
          },
        ),
      ),
    );
  }
}
