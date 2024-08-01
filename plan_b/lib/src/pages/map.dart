import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/setting_page/ui/view/setting_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as s;
import 'package:plan_b/src/pages/gaon.dart';
import 'package:plan_b/src/pages/naon.dart';
import 'package:plan_b/src/pages/room_page/ui/view/daon.dart';
import 'package:plan_b/src/pages/raon.dart';
import 'package:plan_b/src/pages/three.dart';
import 'package:plan_b/src/pages/fours.dart';
import 'package:plan_b/src/pages/fourg.dart';
import 'package:plan_b/src/pages/five.dart';
import 'package:plan_b/main.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_event.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_model.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_state.dart' as n;
import 'package:plan_b/src/pages/notice_page/ui/view/notice_page.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leadingWidth: MediaQuery.of(context).size.width,
          title: Padding(
            padding: EdgeInsets.only(left: 10.0.r),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/lmetaverse.png",
                  width: 24.0.w,
                  height: 24.0.h,
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
        body : Padding(
          padding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, top: 100.0.h),
          child: Column(
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
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "NotoSansKR"
                          ),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const five()),);}, child: Text("학교측"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '4층',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "NotoSansKR"
                          ),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const fours()),);}, child: Text("학교측"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const fourg()),);}, child: Text("기숙사측"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '3층',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "NotoSansKR"
                          ),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const three()),);}, child: Text("기숙사측"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          '1층',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: "NotoSansKR"
                          ),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const gaon()),);}, child: Text("가온실"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const naon()),);}, child: Text("나온실"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=> daon()),);}, child: Text("다온실"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
                              onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const raon()),);}, child: Text("라온실"),style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFFEBEBEB),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
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
          ),
        ),
      ),
    );
  }
}