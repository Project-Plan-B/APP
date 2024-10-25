import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plan_b/src/init/fcm_init.dart';
import 'package:plan_b/src/di/di.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/src/pages/home_page/ui/view/home.dart';
import 'package:plan_b/src/polling_service.dart';
import 'package:plan_b/src/splash_page/ui/view/splash_page.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Color(0xffECFFEB)),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  runApp(App(
    blocList: await di(),
  ));
}

class App extends StatelessWidget{
  const App({super.key, required this.blocList});

  final List<BlocProvider> blocList;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...blocList, // BLoC 리스트 추가
        ChangeNotifierProvider(create: (_) => PollingService()), // PollingService 추가
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (context, child) {
          FlutterLocalNotification.init();
          return MaterialApp(
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
          );
        },
      ),
    );
  }
}

enum CurrentState {
  smooth(
      color: Colors.green,
      deepColor: Color(0xff30DB2C),
      deviceIconColor: Colors.lightGreen,
      text: "원활"),
  common(
      color: Colors.yellow,
      deepColor: Color(0xffFFB342),
      deviceIconColor: Colors.yellow,
      text: "보통"),
  confusion(
      color: Colors.orange,
      deepColor: Colors.orangeAccent,
      deviceIconColor: Colors.deepOrange,
      text: "혼잡"),
  veryconfusion(
      color: Colors.red,
      deepColor: Colors.redAccent,
      deviceIconColor: Colors.red,
      text: "매우 혼잡");

  bool get isWorking => this == CurrentState.smooth;

  bool get isAvailable => this == CurrentState.common;

  bool get isDisconnected => this == CurrentState.confusion;

  bool get isBreakdown => this == CurrentState.veryconfusion;

  final Color color, deepColor, deviceIconColor;
  final String text;

  const CurrentState({
    required this.color,
    required this.deepColor,
    required this.deviceIconColor,
    required this.text,
  });
}

enum RoomName {
  gaon(
    text: "가온실",
  ),
  daon(
    text: "다온실",
  ),
  test(
    text: "TEST",
  ),
  empty(
    text: "",
  );

  bool get isgaon => this == RoomName.gaon;

  bool get istest => this == RoomName.test;

  bool get isEmpty => this == RoomName.empty;

  final String text;

  const RoomName({
    required this.text,
  });
}

enum Pos {
  school(text: "학교"),
  test(text: "TEST");

  bool get isBoy => this == Pos.school;

  bool get isGirl => this == Pos.test;

  const Pos({required this.text});

  final String text;
}

enum RoomLocation {
  schoolSide(roomName: "남자 학교측 세탁실"),
  dormitorySide(roomName: "남자 기숙사측 세탁실"),
  schoolGirlSide(roomName: "여자 기숙사측 세탁실");

  bool get isSchoolSide => this == RoomLocation.schoolSide;

  bool get isDormitorySide => this == RoomLocation.dormitorySide;

  bool get isSchoolGirlSide => this == RoomLocation.schoolGirlSide;

  bool get isNotSchoolGirlSide => this != RoomLocation.schoolGirlSide;

  const RoomLocation({required this.roomName});

  final String roomName;
}

enum LaundryRoomLayer {
  first(icon: Icons.looks_one_outlined),
  second(icon: Icons.looks_two_outlined);

  bool get isFirst => this == LaundryRoomLayer.first;

  bool get isSecond => this == LaundryRoomLayer.second;

  const LaundryRoomLayer({required this.icon});

  final IconData icon;
}
