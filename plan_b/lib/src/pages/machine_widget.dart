import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as m;
import 'package:plan_b/main.dart';
import 'package:plan_b/src/pages/planb_bottom_sheet.dart';

abstract class MachineWidget extends StatelessWidget {
  const MachineWidget({
    super.key,
    required this.deviceId,
    required this.isEnableNotification,
    required this.state,
    required this.roomName,
  });

  final int deviceId;
  final RoomName roomName;
  final CurrentState state;
  final bool isEnableNotification;

  void showModalOSJBottomSheet({required BuildContext context}) =>
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.r),
          ),
        ),
        builder: (context) => OSJBottomSheet(
          deviceId: deviceId,
          isEnableNotification: isEnableNotification,
          state: state,
          machine: roomName,
        ),
      );
}
