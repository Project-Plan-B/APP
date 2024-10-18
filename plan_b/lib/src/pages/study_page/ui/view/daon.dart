import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screenUtil;
import 'package:plan_b/main.dart';
import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/pages/study_page/ui/view/naon.dart';
import 'package:plan_b/src/pages/study_page/ui/widget/humi_gauge.dart';
import 'package:plan_b/src/pages/study_page/ui/widget/machine_button.dart';
import 'package:plan_b/src/pages/setting_page/bloc/laundry_room_model.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_bloc.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_state.dart';
import 'package:plan_b/src/pages/study_page/ui/widget/temp_gauge.dart';

class daon extends StatefulWidget {
  @override
  _daonState createState() => _daonState();
}

class _daonState extends State<daon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _temperatureAnimation;
  late Animation<double> _humidityAnimation;

  final double temperaturePercent = 0.6; // 온도 퍼센트
  final double humidityPercent = 0.7;    // 습도 퍼센트

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1), // 애니메이션 지속 시간
    );

    _temperatureAnimation = Tween<double>(begin: 0, end: temperaturePercent).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _humidityAnimation = Tween<double>(begin: 0, end: humidityPercent).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState<LaundryRoomModel>>(
      builder: (context, roomBlocState) {
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
              "1층 다온실",
              style: TextStyle(
                fontSize: 20.0.sp,
                color: Colors.black,
                fontFamily: "NotoSansKR",
                fontWeight: FontWeight.w700,
              ),
            ),
            titleSpacing: 5,
          ),
          body: Column(
            children: [
              SizedBox(height: 20.h),
              TemperatureGauge(animation: _temperatureAnimation),
              SizedBox(height: 20.h),
              HumidityGauge(animation: _humidityAnimation),
              SizedBox(height: 20.h),
              Container(
                margin: EdgeInsets.all(16.0.w),
                padding: EdgeInsets.all(16.0.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0.h),
                    Container(
                      width: 290.0.w,
                      height: 440.0.w,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColoredBox(color: Color(0xFF30DB2C)),
                              SizedBox(width: 3.0.w),
                              ColoredBox(color: Color(0xFF30DB2C)),
                            ],
                          ),
                          SizedBox(height: 3.0.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColoredBox(color: Color(0xFF30DB2C)),
                              SizedBox(width: 3.0.w),
                              ColoredBox(color: Color(0xFF30DB2C)),
                            ],
                          ),
                          SizedBox(height: 3.0.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColoredBox(color: Color(0xFF30DB2C)),
                              SizedBox(width: 3.0.w),
                              ColoredBox(color: Color(0xFF30DB2C)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior().copyWith(overscroll: false),
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, // MainAxisAlignment 조정
                            children: [
                              MachineButton(
                                laundryEntity: LaundryEntity(
                                  id: 13,
                                  deviceType: DeviceType.daon,
                                  state: CurrentState.smooth,
                                ),
                                isEnableNotification: true,
                              ),
                              SizedBox(width: 40.w), // 간격을 줄이기 위해 추가
                              MachineButton(
                                laundryEntity: LaundryEntity(
                                  id: 13,
                                  deviceType: DeviceType.daon,
                                  state: CurrentState.common,
                                ),
                                isEnableNotification: true,
                              ),
                              SizedBox(width: 40.w), // 간격을 줄이기 위해 추가
                              MachineButton(
                                laundryEntity: LaundryEntity(
                                  id: 13,
                                  deviceType: DeviceType.daon,
                                  state: CurrentState.confusion,
                                ),
                                isEnableNotification: true,
                              ),
                              SizedBox(width: 40.w), // 간격을 줄이기 위해 추가
                              MachineButton(
                                laundryEntity: LaundryEntity(
                                  id: 13,
                                  deviceType: DeviceType.daon,
                                  state: CurrentState.veryconfusion,
                                ),
                                isEnableNotification: true,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ColoredBox extends StatelessWidget {
  final Color color;

  ColoredBox({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0.w,
      height: 140.0.w,
      color: color,
    );
  }
}
