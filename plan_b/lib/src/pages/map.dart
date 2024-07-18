import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/gaon.dart';
import 'package:plan_b/src/pages/naon.dart';
import 'package:plan_b/src/pages/daon.dart';
import 'package:plan_b/src/pages/raon.dart';
import 'package:plan_b/src/pages/three.dart';
import 'package:plan_b/src/pages/fours.dart';
import 'package:plan_b/src/pages/fourg.dart';
import 'package:plan_b/src/pages/five.dart';
import 'package:plan_b/src/pages/setting.dart';

class Map extends StatelessWidget {
  const Map({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal:20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 42,
                ),
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/metaverse.png',width: 45,height: 45,),
                    Row(
                      children: [
                        Icon(Icons.notifications,size: 30,),
                        IconButton(
                          onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const setting()),);},
                          icon : Icon(Icons.settings_rounded),iconSize: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            '5층',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NotoSansKR"
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Container(
                              width: 333,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const five()),);}, child: Text("학교측"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            '4층',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NotoSansKR"
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const fours()),);}, child: Text("학교측"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                            SizedBox(
                              width: 33,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const fourg()),);}, child: Text("기숙사측"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            '3층',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NotoSansKR"
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                          SizedBox(
                            width: 18,
                            ),
                            Container(
                              width: 333,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const three()),);}, child: Text("기숙사측"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Text(
                            '1층',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: "NotoSansKR"
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const gaon()),);}, child: Text("가온실"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                            SizedBox(
                              width: 33,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const naon()),);}, child: Text("나온실"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const daon()),);}, child: Text("다온실"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                            SizedBox(
                              width: 33,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context)=>const raon()),);}, child: Text("라온실"),style: OutlinedButton.styleFrom(
                                backgroundColor: Color(0xFFEBEBEB),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ],

                    )
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