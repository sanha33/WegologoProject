import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_bottom_navigation_bar/pages/mypage/mypage2/1:1_question.dart';
import 'package:getx_bottom_navigation_bar/pages/mypage/mypage2/individual_information.dart';
import 'package:getx_bottom_navigation_bar/pages/mypage/mypage2/terms_and_conditions.dart';
import 'package:getx_bottom_navigation_bar/pages/mypage/mypage2/instruction_manual.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_bottom_navigation_bar/main.dart';

class MyPage extends StatefulWidget {
  //const MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Future<void>mumulSignOut() async {
    await FirebaseAuth.instance.signOut();
    // await googleSignIn.disconnect();
    // await googleSignIn.signOut();
    Get.to(IntroScreen());
    //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyApp()), (Route<dynamic> route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Container(

          width: 380,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                leading: Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")))),

                title: Text(
                  '위고레고 님',
                  // style: body2Style(),
                ),
                subtitle: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '오늘도 행복하세요!',
                        ),
                        Text(
                          'id@handong.edu',
                        ),
                      ],
                    )),

                isThreeLine: true,
                //isThreeLine: true,
              ),
              SizedBox(height:20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  TweenAnimationBuilder(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(seconds: 4),
                    builder: (context, value, _) => SizedBox(
                      width: 300,
                      height: 10,
                      child: LinearProgressIndicator(
                        value: 0.8,
                        backgroundColor: Colors.grey[400],
                        color: Colors.pinkAccent,

                        // strokeWidth: 8,
                      ),
                    ),
                  ),
                ],
              ),


              Container(
                height: 370,
                child: Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildListView(context, index);
                    },
                  ),
                ),
              ),
              Divider(
                color: Colors.grey[20],
                // thickness: 1.0,
              ),
              ListTile(
                  leading: Text("앱버전 정보"),
                  trailing: Text(
                    "0.14",
                    style: TextStyle(fontSize: 20.0),
                  )),
              ElevatedButton(

                style:  ElevatedButton.styleFrom(
                  primary: Color(0XFF7EA68D),
                  shape: RoundedRectangleBorder( //to set border radius to button
                    borderRadius: BorderRadius.circular(10),
                  ),),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: mumulSignOut,
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          '마이페이지',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      // bottomNavigationBar: Navigation(),
    );
  }
}

Widget _buildListView(BuildContext context, int index) {
  final List<String> _list = [
    '활동상태 설정',
    '1:1 문의',
    '무물 사용설명서',
    '개인정보 처리방침',
    '이용약관',
  ];
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.grey[20],
          // thickness: 1.0,
        ),
        ListTile(
          // leading: Text(_list[index]),
          title: Text(
            _list[index],
            style: TextStyle(fontSize: 15.0),
          ),
          trailing: Icon(Icons.arrow_forward_ios,size: 18.0,),

          onTap: () async {
// begin of all IF statements
            if (index == 1) {
              await Get.to(() => Question());
            }
            if (index == 2) {
              await Get.to(() => Instruction());
            }
            if(index == 3){
              await Get.to(() => Information());
            }
            if (index == 4) {
              await Get.to(() => Terms());
            }
// end of all If statements
          },
        ),
      ],
    ),
  );
}
