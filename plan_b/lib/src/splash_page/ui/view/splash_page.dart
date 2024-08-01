import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:plan_b/src/pages/home_page/ui/view/home.dart';
import 'package:plan_b/src/pages/map.dart';
import 'package:plan_b/src/data/home/dto/request/get_home_list_request.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_bloc.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_event.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_bloc.dart';
import 'package:plan_b/src/pages/notice_page/bloc/notice_event.dart';
import 'package:plan_b/src/bottom_navi.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> checkAppVersion() async {
    /*PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    final res = await http.get(Uri.parse(
        "123456/app_ver_${Platform.isAndroid ? "android" : "ios"}"));

    final newestAppVersion = jsonDecode(res.body)['version'];
    final storeState = jsonDecode(res.body)['store_status'];*/

      Future.delayed(const Duration(seconds: 1)).then(
            (value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavi(),
              ),
                  (route) => false);
        },
      );
  }

  @override
  void initState() {
    super.initState();
    checkAppVersion();
    context.read<NoticeBloc>().add(GetNoticeEvent());
    context
        .read<ApplyBloc>()
        .add(GetApplyListEvent(getApplyListRequest: GetApplyListRequest()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/lmetaverse.png",
              width: 100.0.r,
              height: 100.0.r,
            ),
            SizedBox(height: 12.0.h),
          ],
        ),
      ),
    );
  }
}
