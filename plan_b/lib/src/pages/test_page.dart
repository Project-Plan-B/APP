import 'package:flutter/material.dart';
import 'package:plan_b/main.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screenUtil;
import 'package:plan_b/src/pages/study_page/ui/widget/machine_button.dart';
import 'package:plan_b/src/pages/study_page/bloc/study_bloc.dart';
import 'package:plan_b/src/pages/study_page/bloc/study_model.dart';
import 'package:plan_b/src/pages/study_page/bloc/study_state.dart';
import 'package:plan_b/src/pages/setting_page/bloc/laundry_room_model.dart';
import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_bloc.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_event.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_state.dart';
import 'package:plan_b/src/pages/planb_bottom_sheet.dart';
import 'package:plan_b/src/pages/study_page/ui/widget/temp_gauge.dart';
import 'package:plan_b/src/pages/study_page/ui/widget/humi_gauge.dart';
import 'package:plan_b/src/data/study/data_source/sensor_api_service.dart'; // SensorApiService 추가

class test extends StatefulWidget {
  @override
  _testState createState() => _testState();
}

class _testState extends State<test> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _temperatureAnimation;
  late Animation<double> _humidityAnimation;
  late Timer _timer;

  double temperaturePercent = 0.0;
  double humidityPercent = 0.0;
  int Aconfusiondata = 0;
  int Bconfusiondata = 0;
  int Cconfusiondata = 0;
  int Dconfusiondata = 0;
  int Econfusiondata = 0;
  int Fconfusiondata = 0;

  static const Color smooth = Color(0xFF30DB2C);
  static const Color common = Color(0xFFFFF500);
  static const Color confus = Color(0xFFFFB342);
  static const Color veryco = Color(0xFFFF4C4C);

  late final List<LaundryEntity> list;

  final Map<int, int> placeIndex = {0: 0, 1: 16, 2: 31, 3: 47, 4: 63};

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

    _fetchSensorData(); // 데이터를 가져오는 메서드 호출
    _confuData();
    _startPolling();
  }

  void _startPolling() {
    // 5초마다 서버에서 데이터를 가져옴
    _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      await _fetchSensorData(); // 서버에서 온도 및 습도 데이터를 가져옴
      await _confuData(); // 혼잡도 데이터를 가져옴
    });
  }

  Future<void> _fetchSensorData() async {
    try {
      final sensorData = await SensorApiService().fetchSensorData();
      setState(() {
        temperaturePercent = sensorData['temperature'] / 100.0; // 서버에서 받은 데이터 범위에 따라 조정
        humidityPercent = sensorData['humidity'] / 100.0; // 서버에서 받은 데이터 범위에 따라 조정
        _temperatureAnimation = Tween<double>(begin: 0, end: temperaturePercent).animate(_animationController);
        _humidityAnimation = Tween<double>(begin: 0, end: humidityPercent).animate(_animationController);
        _animationController.forward();
      });
    } catch (e) {
      print('Error fetching sensor data: $e');
    }
  }

  Future<void> _confuData() async {
    try{
      final confu = await SensorApiService().confuData();
      setState(() {
        Aconfusiondata = confu['A'];
        Bconfusiondata = confu['B'];
        Cconfusiondata = confu['C'];
        Dconfusiondata = confu['D'];
        Econfusiondata = confu['E'];
        Fconfusiondata = confu['F'];
      });
    } catch (e) {
      print('Error confuData: $e');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
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
              "TEST",
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
                margin: EdgeInsets.all(16.0.w), // 여백 설정
                padding: EdgeInsets.all(16.0.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // 그림자의 위치
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0.h),
                    Container(
                      width: 290.0.w, // 큰 네모의 너비
                      height: 440.0.w, // 큰 네모의 높이
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColoredBox(color: Aconfusiondata == 1 ? smooth : Aconfusiondata == 2 ? common : Aconfusiondata == 3 ? confus : veryco),
                              SizedBox(width: 3.0.w),
                              ColoredBox(color: Bconfusiondata == 1 ? smooth : Bconfusiondata == 2 ? common : Bconfusiondata == 3 ? confus : veryco),
                            ],
                          ),
                          SizedBox(height: 3.0.h), // 행 사이의 간격
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColoredBox(color: Cconfusiondata == 1 ? smooth : Cconfusiondata == 2 ? common : Cconfusiondata == 3 ? confus : veryco),
                              SizedBox(width: 3.0.w),
                              ColoredBox(color: Dconfusiondata == 1 ? smooth : Dconfusiondata == 2 ? common : Dconfusiondata == 3 ? confus : veryco),
                            ],
                          ),
                          SizedBox(height: 3.0.h), // 행 사이의 간격
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ColoredBox(color: Econfusiondata == 1 ? smooth : Econfusiondata == 2 ? common : Econfusiondata == 3 ? confus : veryco),
                              SizedBox(width: 3.0.w),
                              ColoredBox(color: Fconfusiondata == 1 ? smooth : Fconfusiondata == 2 ? common : Fconfusiondata == 3 ? confus : veryco),
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
                                  id: 11,
                                  deviceType: DeviceType.test,
                                  state: CurrentState.smooth,
                                ),
                                isEnableNotification: true,
                              ),
                              SizedBox(width: 40.w), // 간격을 줄이기 위해 추가
                              MachineButton(
                                laundryEntity: LaundryEntity(
                                  id: 11,
                                  deviceType: DeviceType.test,
                                  state: CurrentState.common,
                                ),
                                isEnableNotification: true,
                              ),
                              SizedBox(width: 40.w), // 간격을 줄이기 위해 추가
                              MachineButton(
                                laundryEntity: LaundryEntity(
                                  id: 11,
                                  deviceType: DeviceType.test,
                                  state: CurrentState.confusion,
                                ),
                                isEnableNotification: true,
                              ),
                              SizedBox(width: 40.w), // 간격을 줄이기 위해 추가
                              MachineButton(
                                laundryEntity: LaundryEntity(
                                  id: 11,
                                  deviceType: DeviceType.test,
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

class LaundryList extends StatelessWidget {
  LaundryList({
    super.key,
    required this.list,
    required this.laundryRoomModel,
  });

  final List<LaundryEntity> list;
  final LaundryRoomModel laundryRoomModel;

  final Map<int, int> placeIndex = {0: 0, 1: 16, 2: 31, 3: 47, 4: 63};

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        if (laundryRoomModel.isNFCShowBottomSheet == false) {
          if (laundryRoomModel.showingBottomSheet == true) {
            Navigator.of(context).pop();
          }
          context.read<RoomBloc>().add(ShowBottomSheetEvent());
          context.read<RoomBloc>().add(ShowingBottomSheetEvent());
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.r),
              ),
            ),
            builder: (context) => OSJBottomSheet(
              deviceId: 1,
              isEnableNotification: true,
              state: list[1].state,
              machine: list[1].deviceType,
            ),
          );
        }
      },
    );
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
        itemCount: 8,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MachineButton(
                    laundryEntity: laundryRoomModel.laundryRoomLayer.isFirst
                        ? list[
                    placeIndex[laundryRoomModel.roomLocation.index]! +
                        index]
                        : list[
                    placeIndex[laundryRoomModel.roomLocation.index]! +
                        index +
                        32],
                    isEnableNotification: true,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  runApp(test());
}