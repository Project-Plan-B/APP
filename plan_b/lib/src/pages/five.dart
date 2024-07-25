import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/map.dart';

class five extends StatelessWidget {
  const five({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 45,
                ),
                Row(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    IconButton(icon : Icon(Icons.arrow_back_ios_new_outlined),iconSize: 20,onPressed: () {Navigator.of(context).pop();},),
                    Text(
                      "5층 학교측",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "NotoSansKR",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}