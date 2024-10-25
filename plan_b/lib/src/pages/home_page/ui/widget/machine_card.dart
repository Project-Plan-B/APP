import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plan_b/src/pages/machine_widget.dart';

class MachineCard extends MachineWidget {
  const MachineCard({
    super.key,
    required super.deviceId,
    required super.isEnableNotification,
    required super.roomName,
    required super.state,
  });

  @override
  Widget build(BuildContext context) {
    return roomName.isEmpty
        ? Container(
      width: 170.0.r,
      padding: EdgeInsets.only(top: 10.0.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "1층 다온실",
            textScaler: TextScaler.noScaling,
            style: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.w500,
                color: Colors.transparent),
          ),
          Container(
            padding: EdgeInsets.all(8.0.r),
            child: Text(
              "원활",
              textAlign: TextAlign.center,
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                color: Colors.transparent,
                fontSize: 20.0.sp,
              ),
            ),
          ),
        ],
      ),
    )
        : GestureDetector(
      onTap: () => showModalOSJBottomSheet(context: context),
      child: Container(
        width: 170.0.r,
        padding: EdgeInsets.only(top: 10.0.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8,bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              deviceId==0?
              Text(
                "${roomName.text}",
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontFamily: "NotoSansKR",
                  fontWeight: FontWeight.w600,
                ),
              )
              :Text(
                "${deviceId}층 ${roomName.text}",
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  fontSize: 20.0.sp,
                  fontFamily: "NotoSansKR",
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                child: Text(
                  state.text,
                  textAlign: TextAlign.center,
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(
                    color: state.deepColor,
                    fontSize: 20.0.sp,
                    fontFamily: "NotoSansKR",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}