import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/home.dart';
import 'package:plan_b/src/pages/map.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget{
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

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

class _AppState extends State<App> with SingleTickerProviderStateMixin{
  late TabController controller;
  int selectedIndex = 1;
  bool isChange = false;

  void initState(){
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : Scaffold(
        backgroundColor: Colors.white,
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
                    ? Color(0xFFEBEBEB)
                    : Colors.white,
                iconColor: selectedIndex == 0
                    ? Color(0xFF27AB00)
                    : Color(0xFFEBEBEB),
                iconData: Icons.home),
            OSJImageButton(
              width: 185.0,
              height: 48.0,
              color:
              selectedIndex == 1 ? Color(0xFFEBEBEB) : Colors.white,
              imagePath: selectedIndex == 1
                  ? "assets/images/metaverse3.png"
                  : "assets/images/metaverse2.png",
            ),
          ],
        ),
      ),
    );
  }
}
