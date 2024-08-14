import 'package:flutter/material.dart';
import 'package:plan_b/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class daon extends StatefulWidget {
  @override
  _daonState createState() => _daonState();
}

class _daonState extends State<daon> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _temperatureAnimation;
  late Animation<double> _humidityAnimation;

  final double temperaturePercent = 0.8; // 온도 퍼센트
  final double humidityPercent = 0.9;    // 습도 퍼센트

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
        return switch (roomBlocState) {
          Initial() => const Center(child: CircularProgressIndicator()),
          Changed() => Scaffold(
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
                  fontWeight: FontWeight.bold,
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
                                ColoredBox(color: Color(0xFF30DB2C)),
                                SizedBox(width: 3.0.w),
                                ColoredBox(color: Color(0xFFFFB342)),
                              ],
                            ),
                            SizedBox(height: 3.0.h), // 행 사이의 간격
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ColoredBox(color: Color(0xFFFF4C4C)),
                                SizedBox(width: 3.0.w),
                                ColoredBox(color: Color(0xFFFFF500)),
                              ],
                            ),
                            SizedBox(height: 3.0.h), // 행 사이의 간격
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ColoredBox(color: Color(0xFFFFB342)),
                                SizedBox(width: 3.0.w),
                                ColoredBox(color: Color(0xFFFF4C4C)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                  BlocBuilder<LaundryBloc, LaundryState<LaundryModel>>(
                    builder: (context, state) {
                      return switch (state) {
                        Empty() => const Center(child: Text("비어있음")),
                        Loading() =>
                        const Center(child: CircularProgressIndicator()),
                        Error() =>
                        const Center(child: Text("인터넷 연결을 확인해주세요")),
                        Loaded() =>
                        LaundryList(
                          list: state.data.laundryList,
                          laundryRoomModel: roomBlocState.value,
                        ),
                      };
                    },
                  ),
                ),
              ],
            ),
          ),
        };
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
        // laundryRoomModel.roomLocation == RoomLocation.womanRoom ? 10 : 8,
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
  runApp(daon());
}
