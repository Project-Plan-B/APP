import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/study_page/ui/view/daon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class TemperatureGauge extends StatelessWidget {
  final Animation<double> animation;

  TemperatureGauge({required this.animation});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20.0.h),
          child: LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: 330.0.w,
            lineHeight: 25.0.h,
            percent: animation.value,
            barRadius: Radius.circular(16.0),
            progressColor: animation.value <= 0.25 ? Color(0xff164ED4) : animation.value <= 0.5 ? Color(0xFF30DB2C) : animation.value <= 0.75 ? Color(0xFFFFB342):Color(0xFFFF4C4C),
            backgroundColor: Colors.white,
          ),
        ),
        Positioned(
          left: (330.0.w - 5.0.r) * animation.value + 8.0.r, // 더 세밀하게 조정
          top: 20.0.h,
          child: Icon(
            Icons.thermostat,
            color: animation.value < 0.12 ? Colors.transparent : Colors.white,
            size: 25.0.r,
          ),
        ),
        Positioned(
          left: 63.0.w,
          top: -3.0.h,
          child: Text(
            '현재 온도',
            style: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black,
              fontFamily: "NotoSansKR",
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Positioned(
          right: 65.0.w,
          top: -3.0.h,
          child: Text(
            '${(animation.value*100/2).toInt()}°C',
            style: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.black,
              fontFamily: "NotoSansKR",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}