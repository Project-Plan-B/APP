import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:plan_b/main.dart';
import 'package:plan_b/src/pages/home_page/ui/view/home.dart';
import 'package:plan_b/src/pages/map.dart';

class OSJIconButton extends StatelessWidget {
  const OSJIconButton(
      {super.key,
        required this.width,
        required this.height,
        required this.iconSize,
        required this.color,
        required this.iconColor,
        required this.iconData,
        this.function});

  final double width, height, iconSize;
  final Color color, iconColor;
  final IconData iconData;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function != null ? () => function : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Icon(iconData, size: iconSize, color: iconColor),
        ),
      ),
    );
  }
}

class OSJImageButton extends StatelessWidget {
  const OSJImageButton({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.imagePath,
    this.function,
    this.imageWidth,
    this.imageHeight,
  });

  final double width, height;
  final double? imageWidth, imageHeight;
  final Color color;
  final String imagePath;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function != null ? () => function : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Center(
          child: Image.asset(
            imagePath,
            width: imageWidth ?? 24.0,
            height: imageHeight ?? 24.0,
          ),
        ),
      ),
    );
  }
}

class BottomNavi extends StatefulWidget {
  BottomNavi({super.key});

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController controller;

  int selectedIndex = 1;
  bool isChange = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    controller = TabController(length: 2, vsync: this)
      ..index = 1
      ..animation?.addListener(() {
        if (controller.offset >= 0.5 &&
            controller.offset < 1.0 &&
            isChange == false) {
          setState(() {
            isChange = true;
            selectedIndex = 1;
          });
        }
        if (controller.offset < 0.5 &&
            controller.offset > 0.0 &&
            isChange == true) {
          setState(() {
            isChange = false;
            selectedIndex = 0;
          });
        }
        if (controller.offset >= -0.5 &&
            controller.offset < 0.0 &&
            isChange == false) {
          setState(() {
            isChange = true;
            selectedIndex = 1;
          });
        }
        if (controller.offset < -0.5 &&
            controller.offset > -1.0 &&
            isChange == true) {
          setState(() {
            isChange = false;
            selectedIndex = 0;
          });
        }
        if (controller.offset == 1.0 || controller.offset == 0.0) {
          setState(() {
            isChange = false;
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F0),
      body: TabBarView(
        controller: controller,
        children: [
          Home(),
          Map(),
        ],
      ),
      bottomNavigationBar: TabBar(
        padding: EdgeInsets.only(top: 10.0, bottom: 30.0),
        dividerColor: Colors.transparent,
        controller: controller,
        indicatorColor: Colors.transparent,
        tabs: [
          OSJIconButton(
              width: 185.0,
              height: 48.0,
              iconSize: 24.0,
              color: selectedIndex == 0
                  ? Colors.white
                  : Color(0xFFF1F3F0),
              iconColor: selectedIndex == 0
                  ? Color(0xFF27AB00)
                  : Color(0xffADB3BD),
              iconData: Icons.home),
          OSJImageButton(
            width: 185.0,
            height: 48.0,
            color:
            selectedIndex == 1 ? Colors.white : Color(0xFFF1F3F0),
            imagePath: selectedIndex == 1
                ? "assets/images/lmetaverse.png"
                : "assets/images/unmetavers.png",
          ),
        ],
      ),
    );
  }
}