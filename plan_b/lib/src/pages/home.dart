import 'package:flutter/material.dart';
import 'package:plan_b/src/pages/setting.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: SingleChildScrollView(
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
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '이제는 편리하게\n자습실 혼잡도를 확인',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              fontFamily: "NotoSansKR"
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: 'PLAN-B',
                              style: TextStyle(
                                color: Color(0xFF27AB00),
                                fontSize: 10,
                                fontFamily: "NotoSansKR",
                                fontWeight: FontWeight.w700,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '를 사용하여 모든 자습실의 정보를\n누구보다 빠르게 확인하세요.',
                                    style: TextStyle(
                                      color: Color(0xFFA9A9A9),
                                      fontFamily: "NotoSansKR",
                                      fontWeight: FontWeight.w700,
                                    )
                                )
                              ]
                          ),
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