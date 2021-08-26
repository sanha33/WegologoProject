import 'package:getx_bottom_navigation_bar/pages/login/mumul_sign_up.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_page.dart';
import 'package:getx_bottom_navigation_bar/pages/login/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'mumul_login.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:get/get.dart';
import 'package:getx_bottom_navigation_bar/pages/login/login_controller.dart';

//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginViewState createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginPage> {

class LoginPage extends GetView<LoginPageController> {
  LoginPageController loginController = Get.find<LoginPageController>();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final List<Widget> steps = [
      //_step0(),
      _step1(),
      _step2(),
      _step3(),
      _step4(),
    ];

    return Scaffold(
        body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: ScreenUtil().setHeight(240)),
                  Container(
                    constraints: BoxConstraints.expand(
                        height: 200
                    ),
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return steps[index];
                      },
                      loop: false,
                      autoplay: true,
                      itemCount: steps.length,
                      viewportFraction: 0.8,
                      scale: 0.9,

                      pagination: new SwiperPagination(
                        alignment: Alignment.bottomCenter,
                        builder: new DotSwiperPaginationBuilder(
                            color: Colors.grey[200], activeColor: Color(0XFF7EA68D)),
                      ),

                      //control: new SwiperController(),
                    ),
                    //imageSlider(context)
                  ),
                  InkWell(
                    onTap: () => loginController.handleGoogleSignIn().catchError((err){

                    }),
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Ink(
                      height: ScreenUtil().setHeight(60),
                      width: ScreenUtil().setHeight(350),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/kakao_login.jpeg'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  //google
                  InkWell(
                    onTap: () => loginController.handleGoogleSignIn().catchError((err){

                    }),
                    splashColor: Colors.grey.withOpacity(0.5),
                    child: Ink(
                      height: ScreenUtil().setHeight(60),
                      width: ScreenUtil().setHeight(350),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/google_button.jpeg'),
                            fit: BoxFit.cover
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 376),
                      //context.width),
                      child: TextButton(
                        child: Text(
                          "다른방법으로 로그인 ",
                          style: TextStyle(fontSize: ScreenUtil().setSp(16), color: Colors.grey,decoration: TextDecoration.underline,),
                        ),
                        onPressed: () {
                          //Get.to(AuthApp());
                          Dialogs.bottomMaterialDialog(
                            //msg:'다른방법으로 로그인 ',
                              context: context,
                              actions: [
                                Column(
                                    children:[
                                      /*
                                      Transform.scale(
                                        scale: 9.0,
                                        child: IconButton(
                                          icon: Image.asset('images/facebook_login.jpeg',),
                                          onPressed: (){
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Transform.scale(
                                        scale: 9.0,
                                        child: IconButton(
                                          icon: Image.asset('images/naver_login.jpeg',),
                                          onPressed: (){
                                          },
                                        ),
                                      ),*/
                                      //SizedBox(height: 10,),
                                      Transform.scale(
                                        scale: 9.0,
                                        child: IconButton(
                                          icon: Image.asset('images/mumul_login.jpeg',),
                                          onPressed:(){Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => MumulLogin()));} ,

                                        ),
                                      ),
                                    ]
                                )
                              ]
                          );
                        },
                      ),
                    ),
                  ),
                  /*
          Column(
            children:<Widget>[
              ElevatedButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      Get.to(AuthApp());
                    },
                    child: const Text('sign up'),
              ),
              ]
          )*/

                ],
              ),
            )
        )
    );
  }

// import 'package:flutter/material.dart';
// import 'package:flutter_signin_button/button_list.dart';
// import 'package:flutter_signin_button/button_view.dart';
// import 'package:get/get.dart';
// import 'package:getx_bottom_navigation_bar/pages/login/login_controller.dart';
//
// class LoginPage extends GetView<LoginPageController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               "images/cat.jpeg",
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Google SignIn",
//               //style: TextStyle(fontSize: 40, color: Colors.white),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 16, right: 16),
//               child: SignInButton(
//                   Buttons.Google,
//                   onPressed: (){
//                     controller.login();
//                   }
//               ),
//               // child: ConstrainedBox(
//               //   constraints: BoxConstraints.tightFor(width: context.width),
//               //   child: ElevatedButton(
//               //     child: Text(
//               //       "Sign In with Google",
//               //       style: TextStyle(fontSize: 18, color: Colors.black),
//               //     ),
//               //     onPressed: () {
//               //       controller.login();
//               //     },
//               //   ),
//               // ),
//             ),
//             SizedBox(
//               height: 16,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

}

Widget _step0() {
  return TextField(
    decoration: InputDecoration(labelText: "Add Elements"),
    onSubmitted: (elem) {},
  );
}

Widget _step1() {
  return Container(
      child: Column(children: [
    Image.asset(
      'images/MM_logo.png',
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(67),
    ),
    SizedBox(height: ScreenUtil().setHeight(26)),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        '무',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
      ),
      Text('엇이든 ', style: TextStyle(fontSize: ScreenUtil().setSp(28))),
      Text('물',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D))),
      Text('어보세요!', style: TextStyle(fontSize: ScreenUtil().setSp(28))),
    ]),
    Text('''
어디서든 무엇이든
모두가 도움을 주고받을수 있는 ''',
        maxLines: 20,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: ScreenUtil().setSp(14))),
  ]));
}

Widget _step2() {
  return Container(
      child: Column(children: [
    Image.asset(
      'images/friends.png',
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(67),
    ),
    SizedBox(height: ScreenUtil().setHeight(26)),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        '''  누구에게나
자유로운 질문''',
        style: TextStyle(
            fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
      ),
    ]),
  ]));
}

Widget _step3() {
  return Container(
      child: Center(
    child: Column(children: [
      Image.asset(
        'images/friends.png',
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(67),
      ),
      SizedBox(height: ScreenUtil().setHeight(26)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '''다양한 카테고리의 질문''',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
        ),
      ]),
    ]),
  ));
}

Widget _step4() {
  return Container(
      child: Center(
    child: Column(children: [
      Image.asset(
        'images/mm_light_logo.png',
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setHeight(67),
      ),
      SizedBox(height: ScreenUtil().setHeight(26)),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          '''      지금 가입하고
 도움을 나누어 보세요 ''',
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28), color: Color(0XFF7EA68D)),
        ),
      ]),
    ]),
  ));
}
