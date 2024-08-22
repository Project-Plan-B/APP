import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/study_page/ui/view/daon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HumidityGauge extends StatelessWidget {
  final Animation<double> animation;

  HumidityGauge({required this.animation});

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
            progressColor: Color(0xff3C70EC),
            backgroundColor: Colors.white,
          ),
        ),
        Positioned(
          // 아이콘을 percent의 끝부분과 일정하게 가깝게 설정
          left: (330.0.w - 5.0.r) * animation.value + 8.0.r, // 더 세밀하게 조정
          top: 20.0.h,
          child: Icon(
            Icons.water_drop,
            color: animation.value < 0.12 ? Colors.transparent : Colors.white,
            size: 25.0.r,
          ),
        ),
        Positioned(
          left: 63.0.w,
          top: -3.0.h,
          child: Text(
            '현재 습도',
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
            '${(animation.value*100).toInt()}%',
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