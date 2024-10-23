import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as s;
import 'package:plan_b/main.dart';
import 'package:plan_b/src/data/home/dto/response/set_alert_response.dart';
import 'package:plan_b/src/init/fcm_init.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_bloc.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_event.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_model.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_state.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_event.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_model.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_state.dart' as n;
import 'package:plan_b/src/pages/notice_page/ui/view/notice_page.dart';
import 'package:plan_b/src/pages/home_page/ui/widget/machine_card.dart';
import 'package:plan_b/src/pages/setting_page/ui/view/setting_page.dart';
import 'package:plan_b/src/polling_service.dart';

class Home extends StatelessWidget {
  Home({super.key});

  static int count = 1;  // 초기 count 값

  final TextStyle bigStyle = TextStyle(
    fontSize: 32.0.sp,
    color: Colors.black,
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w700,
  );

  final TextStyle smallStyle = TextStyle(
    fontSize: 17.0.sp,
    color: Color(0xFFA9A9A9),
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w500,
  );

  final TextStyle smallStyle2 = TextStyle(
    fontSize: 17.0.sp,
    color: Color(0xFF27AB00),
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w500,
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
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
              size: 24.0.r,
            ),
          ),
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
                            style: smallStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: BlocBuilder<ApplyBloc, ApplyState<SetAlertResponse>>(
                builder: (context, state) {
                  // count가 0일 때 비어있음 메시지와 이벤트 트리거
                  if (count == 0) {
                    // 이벤트 트리거: roomId와 confusionLevel을 적절히 전달
                    context.read<ApplyBloc>().add(SetConfusionEvent(
                      roomId: -1, // 예시로 deviceId 대신 -1 사용
                      confusionLevel: 0,
                    ));
                    return Center(child: Text("비어있음"));
                  }

                  // 상태에 따른 UI 렌더링
                  switch (state) {
                    case Empty():
                      return const Center(child: Text("비어있음"));
                    case Loading():
                      return const Center(child: CircularProgressIndicator());
                    case Error():
                      return const Center(child: Text("인터넷 연결을 확인해주세요"));
                    case Loaded():
                      return ScrollConfiguration(
                        behavior:
                        const ScrollBehavior().copyWith(overscroll: false),
                        child: ListView.builder(
                          itemCount: count,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    MachineCard(
                                      deviceId: state.value.roomFloor,
                                      isEnableNotification: false,
                                      roomName: state.value.roomName == "가온실"
                                          ? RoomName.gaon
                                          : RoomName.test,
                                      state: state.value.Confusion == 1
                                          ? CurrentState.smooth
                                          : state.value.Confusion == 2
                                          ? CurrentState.common
                                          : state.value.Confusion == 3
                                          ? CurrentState.confusion
                                          : CurrentState.veryconfusion,
                                    ),
                                    index * 2 + 1 < 1
                                        ? MachineCard(
                                      deviceId: state.value.roomFloor,
                                      isEnableNotification: false,
                                      roomName: state.value.roomName ==
                                          "가온실"
                                          ? RoomName.gaon
                                          : RoomName.test,
                                      state: state.value.Confusion == 1
                                          ? CurrentState.smooth
                                          : state.value.Confusion == 2
                                          ? CurrentState.common
                                          : state.value.Confusion == 3
                                          ? CurrentState.confusion
                                          : CurrentState
                                          .veryconfusion,
                                    )
                                        : const MachineCard(
                                      deviceId: -1,
                                      isEnableNotification: false,
                                      roomName: RoomName.empty,
                                      state: CurrentState.smooth,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0.r),
                              ],
                            );
                          },
                        ),
                      );
                    default:
                      return const Center(child: Text("알 수 없는 상태"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
