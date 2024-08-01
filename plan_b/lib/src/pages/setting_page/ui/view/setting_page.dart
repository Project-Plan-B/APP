import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_event.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
          "설정",
          style: TextStyle(
            fontSize: 24.0.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.0.r,
          vertical: 12.0.r,
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async => await launchUrl(
                  Uri.parse('https://open.kakao.com/o/sHjnH1Se'),
                  mode: LaunchMode.externalApplication),
              behavior: HitTestBehavior.translucent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "문의하기",
                    style: TextStyle(fontSize: 18.0.sp),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                    size: 30.0.r,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
