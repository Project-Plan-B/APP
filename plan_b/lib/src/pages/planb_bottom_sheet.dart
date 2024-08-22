import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as s;
import 'package:plan_b/main.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_bloc.dart';
import 'package:plan_b/src/pages/home_page/bloc/home_event.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_bloc.dart';
import 'package:plan_b/src/pages/setting_page/bloc/room_event.dart';

class OSJTextButton extends StatelessWidget {
  const OSJTextButton({
    super.key,
    required this.fontSize,
    required this.color,
    required this.fontColor,
    required this.text,
    this.width,
    this.height,
    this.function,
    this.padding = EdgeInsets.zero,
    this.radius = 15.0,
  });

  final double? width, height;
  final double fontSize, radius;
  final Color color, fontColor;
  final String text;
  final VoidCallback? function;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: fontColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class OSJBottomSheet extends StatefulWidget {
  const OSJBottomSheet({
    super.key,
    required this.deviceId,
    required this.isEnableNotification,
    required this.state,
    required this.machine,
  });

  final int deviceId;
  final bool isEnableNotification;
  final CurrentState state;
  final DeviceType machine;

  @override
  State<OSJBottomSheet> createState() => _OSJBottomSheetState();
}

class _OSJBottomSheetState extends State<OSJBottomSheet> {
  String text(bool isEnableNotification, CurrentState state) {
    if (isEnableNotification) {
      switch (state) {
        case CurrentState.smooth:
          return "${widget.machine.text}의 혼잡도가\n${widget.state.text}이 되면 알림을 전송할까요?";
        case CurrentState.common:
          return "${widget.machine.text}의 혼잡도가\n${widget.state.text}이 되면 알림을 전송할까요?";
        case CurrentState.confusion:
          return "${widget.machine.text}의 혼잡도가\n${widget.state.text}이 되면 알림을 전송할까요?";
        case CurrentState.veryconfusion:
          return "${widget.machine.text}의 혼잡도가\n${widget.state.text}이 되면 알림을 전송할까요?";
      }
    } else {
      return "${widget.machine.text}의 ${widget.state.text}\n알림 설정을 해제하실건가요?";
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(ShowingBottomSheetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) async {
        context.read<RoomBloc>().add(ClosingBottomSheetEvent());
        return Future(() => true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 32.0.r, horizontal: 24.0.r),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Wrap(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24.0.r),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.0.r),
                    Text(
                      text(widget.isEnableNotification, widget.state),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22.0.sp,
                          fontFamily: "NotoSansKR",
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.state.isWorking || widget.state.isAvailable || widget.state.isDisconnected || widget.state.isBreakdown
                ? Row(
              children: [
                Expanded(
                  child: OSJTextButton(
                    function: () {
                      Navigator.of(context).pop();
                      context.read<RoomBloc>().add(ClosingBottomSheetEvent());
                    },
                    fontSize: 14.0.sp,
                    color: Color(0xffEBEBEB),
                    fontColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15.0.r),
                    text: "취소",
                  ),
                ),
                SizedBox(width: 16.0.r),
                Expanded(
                  child: OSJTextButton(
                    function: () {
                      widget.isEnableNotification
                          ? context.read<ApplyBloc>().add(SetConfusionEvent(
                          roomId: widget.deviceId,
                          confusionLevel: widget.state==CurrentState.smooth ? 1 :widget.state==CurrentState.common ? 2 : widget.state==CurrentState.confusion ? 3 : 4 ))
                          : context
                          .read<ApplyBloc>()
                          .add(SetConfusionEvent(
                        roomId: widget.deviceId,
                        confusionLevel: 0
                      ));
                      context
                          .read<RoomBloc>()
                          .add(ClosingBottomSheetEvent());
                      Navigator.pop(context);
                    },
                    fontSize: 14.0.sp,
                    color: Color(0xff30DB2C),
                    fontColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.0.r),
                    text: widget.isEnableNotification
                        ? "확인"
                        : "알림 해제",
                  ),
                ),
              ],
            )
                : OSJTextButton(
              function: () {
                context.read<RoomBloc>().add(ClosingBottomSheetEvent());
                Navigator.of(context).pop();
              },
              fontSize: 16.0.sp,
              color: Colors.white,
              fontColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 15.0.r),
              text: "확인",
            ),
          ],
        ),
      ),
    );
  }
}
