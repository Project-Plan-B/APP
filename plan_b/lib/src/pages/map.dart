import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/setting_page/bloc/laundry_room_model.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_bloc.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_event.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_state.dart';
import 'package:plan_b/src/pages/setting_page/ui/view/setting_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as s;
import 'package:plan_b/src/pages/study_page/ui/view/gaon.dart';
import 'package:plan_b/src/pages/study_page/ui/view/naon.dart';
import 'package:plan_b/src/pages/study_page/ui/view/daon.dart';
import 'package:plan_b/src/pages/study_page/ui/view/raon.dart';
import 'package:plan_b/src/pages/test_page.dart';
import 'package:plan_b/src/pages/study_page/ui/view/three.dart';
import 'package:plan_b/src/pages/study_page/ui/view/fours.dart';
import 'package:plan_b/src/pages/study_page/ui/view/fourg.dart';
import 'package:plan_b/src/pages/study_page/ui/view/five.dart';
import 'package:plan_b/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_event.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_model.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_state.dart' as n;
import 'package:plan_b/src/pages/notice_page/ui/view/notice_page.dart';
import 'package:plan_b/src/pages/setting_page/ui/widget/setting_page_bottom_sheet.dart';

class Map extends StatefulWidget {
  Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {

  final TextStyle floorStyle = TextStyle(
    fontSize: 14.0.sp,
    color: Colors.black,
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w600,
  );

  final TextStyle roomStyle = TextStyle(
    color: Colors.black,
    fontFamily: "NotoSansKR",
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();
    // RoomBloc과 NoticeBloc에서 초기 이벤트 발생
    context.read<RoomBloc>().add(GetRoomIndexEvent());
    context.read<NoticeBloc>().add(UpdateLastNoticeIdEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState<LaundryRoomModel>>(
      builder: (context, roomBlocState) {
        return switch (roomBlocState) {
          Initial() => const Center(child: CircularProgressIndicator()),
          Changed() =>
              Scaffold(
                backgroundColor: Color(0xFFF1F3F0),
                appBar: AppBar(
                  backgroundColor: Color(0xFFF1F3F0),
                  elevation: 0.0,
                  leadingWidth: MediaQuery
                      .of(context)
                      .size
                      .width,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NoticePage()));
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
                        //),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingPage())),
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 28.0.r,
                      ),
                    ),
                    SizedBox(width: 24.0.w),
                  ],
                ),

                body: Padding(
                  padding: EdgeInsets.only(
                      left: 24.0.w, right: 24.0.w, top: 80.0.h),
                  child: roomBlocState.data.roomLocation.isNotSchoolGirlSide ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                    '5층',
                                    style: floorStyle
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                    width: 333,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (
                                                context) => const five()),);
                                      },
                                      child: Text("학교측"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                    '4층',
                                    style: floorStyle
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (
                                                context) => const fours()),);
                                      },
                                      child: Text("학교측"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 33,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (
                                                context) => const fourg()),);
                                      },
                                      child: Text("기숙사측"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                    '3층',
                                    style: floorStyle
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                    width: 333,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (
                                                context) => const three()),);
                                      },
                                      child: Text("기숙사측"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                    '1층',
                                    style: floorStyle
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (context) => gaon()),);
                                      },
                                      child: Text("가온실"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 33,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (
                                                context) => const naon()),);
                                      },
                                      child: Text("나온실"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (context) => daon()),);
                                      },
                                      child: Text("다온실"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 33,
                                  ),
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context, MaterialPageRoute(
                                            builder: (
                                                context) => const raon()),);
                                      },
                                      child: Text("라온실"),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.black,
                                        textStyle: roomStyle,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ) : Center(child:
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (
                                context) => test()),);
                      },
                      child: Text("TEST"),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        textStyle: roomStyle,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0),
                        ),
                      ),
                    ),
                  ),),
                ),
              ),
        };
      },
    );
  }
}