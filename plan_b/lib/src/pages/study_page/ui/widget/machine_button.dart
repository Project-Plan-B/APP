import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/main.dart';
import 'package:plan_b/src/domain/study/entity/study_entity.dart';
import 'package:plan_b/src/pages/machine_widget.dart';

class MachineButton extends MachineWidget{
  final LaundryEntity laundryEntity;

  MachineButton({
    super.key,
    required this.laundryEntity,
    required super.isEnableNotification,
  }) : super(
    deviceId: laundryEntity.id,
    deviceType: laundryEntity.deviceType,
    state: laundryEntity.state,
  );

  Color getStateColor(CurrentState state) {
    switch (state) {
      case CurrentState.smooth:
        return Color(0xFF30DB2C);
      case CurrentState.common:
        return Color(0xFFFFF500);
      case CurrentState.confusion:
        return Color(0xFFFFB342);
      case CurrentState.veryconfusion:
        return Color(0xFFFF4C4C);
      default:
        return Colors.grey;
    }
  }

  String getStateText(CurrentState state) {
    switch (state) {
      case CurrentState.smooth:
        return "원활";
      case CurrentState.common:
        return "보통";
      case CurrentState.confusion:
        return "혼잡";
      case CurrentState.veryconfusion:
        return "매우 혼잡";
      default:
        return "알 수 없음";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => showModalOSJBottomSheet(context: context),
          child: Container(
            padding: EdgeInsets.all(18.r),
            decoration: BoxDecoration(
              color: getStateColor(laundryEntity.state),
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          getStateText(laundryEntity.state),
          style: TextStyle(
            fontSize: 14.0.sp,
              fontFamily: "NotoSansKR",
              fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }
}
