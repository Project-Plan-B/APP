import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as s;
import 'package:plan_b/main.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_bloc.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_model.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_state.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_event.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_model.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_state.dart' as n;
import 'package:plan_b/src/pages/notice_page/ui/view/notice_page.dart';
import 'package:plan_b/src/pages/home_page/ui/widget/machine_card.dart';
import 'package:plan_b/src/pages/setting_page/ui/view/setting_page.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final TextStyle bigStyle = TextStyle(
    fontSize: 32.0.sp,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  final TextStyle smallStyle = TextStyle(
    fontSize: 17.0.sp,
    color: Color(0xFFA9A9A9),
  );

  final TextStyle smallStyle2 = TextStyle(
    fontSize: 17.0.sp,
    color: Color(0xFF27AB00),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF1F3F0),
        appBar: AppBar(
          backgroundColor: Color(0xFFF1F3F0),
          elevation: 0.0,
          leadingWidth: MediaQuery.of(context).size.width,
          title: Padding(
            padding: EdgeInsets.only(left: 9.0.r),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/lmetaverse.png",
                  width: 30.0.w,
                  height: 30.0.h,
                ),
                SizedBox(width: 8.0.w),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<NoticeBloc>().add(UpdateLastNoticeIdEvent());
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NoticePage()));
              },
              icon: /*BlocBuilder<NoticeBloc, n.NoticeState<NoticeModel>>(
                builder: (context, state) => state.value.isNewNotice
                    ? Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 24.0.r,
                        ),
                        Container(
                          width: 10.0.r,
                          height: 10.0.r,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    )
                  : */Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 24.0.r,
                  ),
              ),
            //),
            IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SettingPage())),
                icon: Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 28.0.r,
                )),
            SizedBox(width: 24.0.w),
          ],
        ),
      body: Padding(
        padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 36.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("이제는 편리하게\n공간 혼잡도를 확인", style: bigStyle),
                  SizedBox(height: 22.0.h),
                  RichText(
                    text: TextSpan(
                        text: 'PLAN-B',
                        style: smallStyle2,
                        children: <TextSpan>[
                          TextSpan(
                              text: '를 사용하여 모든 공간의 정보를\n누구보다 빠르게 확인하세요.',
                              style: smallStyle
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0.h),
            Expanded(
              child: BlocBuilder<ApplyBloc, ApplyState<ApplyModel>>(
                builder: (context, state) {
                  return switch (state) {
                    Empty() => const Center(child: Text("비어있음")),
                    Loading() =>
                    const Center(child: CircularProgressIndicator()),
                    Error() => const Center(child: Text("인터넷 연결을 확인해주세요")),
                    Loaded() => ScrollConfiguration(
                      behavior:
                      const ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                        itemCount: state.value.applyList.length.isEven
                            ? state.value.applyList.length ~/ 2
                            : state.value.applyList.length ~/ 2 + 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                                children: [
                                  MachineCard(
                                      deviceId: state.value
                                          .applyList[index * 2].deviceId,
                                      isEnableNotification: false,
                                      deviceType: state.value
                                          .applyList[index * 2].deviceType,
                                      state: CurrentState.smooth),
                                  index * 2 + 1 < state.value.applyList.length
                                      ? MachineCard(
                                      deviceId: state
                                          .value
                                          .applyList[index * 2 + 1]
                                          .deviceId,
                                      isEnableNotification: false,
                                      deviceType: state
                                          .value
                                          .applyList[index * 2 + 1]
                                          .deviceType,
                                      state: CurrentState.smooth)
                                      : const MachineCard(
                                    //리팩토링 꼭 하기
                                      deviceId: -1,
                                      isEnableNotification: false,
                                      deviceType: DeviceType.empty,
                                      state: CurrentState.smooth)
                                ],
                              ),
                              SizedBox(height: 20.0.r),
                            ],
                          );
                        },
                      ),
                    ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
      );
  }
}