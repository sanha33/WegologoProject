import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:getx_bottom_navigation_bar/pages/first/first_controller.dart';
import 'package:getx_bottom_navigation_bar/navigation/customFullScreenDialog.dart';

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


class LoginPageController extends GetxController {



  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences? prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  User? currentUser;

  // @override
  // void initState(){
  //   super.initState();
  //   isSignedIn();
  // }

  @override
  void onInit() {
    super.onInit();
  }

  void isSignedIn() async {
    // this.setState(() {
    //   isLoading = true;
    // }

    //);

    //prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if(isLoggedIn && prefs?.getString('id')!=null){

      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context)=>WelcomePage()));

      Get.to(HomePage());

    }

    // this.setState(() {
    //   isLoading = false;
    // });
  }



  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future<void> handleGoogleSignIn() async {
    //prefs = await SharedPreferences.getInstance();

    GoogleSignInAccount? googleLogin = await googleSignIn.signIn();
    if(googleLogin != null){
      GoogleSignInAuthentication? googleAuth = await googleLogin.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      User? user = (await firebaseAuth.signInWithCredential(credential)).user;

      if(user != null){
        final QuerySnapshot addUser =
        await FirebaseFirestore.instance.collection('users').where('id', isEqualTo: user.uid).get();
        final List<DocumentSnapshot> userList = addUser.docs;
        if(userList.length == 0){
          FirebaseFirestore.instance.collection('users').doc(user.uid).set(
              {'userName': user.displayName,
                'photoUrl': user.photoURL,
                'uid': user.uid,
                'email': user.email,
                'timeRegister': DateTime.now().millisecondsSinceEpoch.toString()});
          currentUser = user;
          // await prefs?.setString('uid', currentUser!.uid);
          // await prefs?.setString('userName', currentUser!.displayName ?? "");
          // await prefs?.setString('photoUrl', currentUser!.photoURL ?? "");
        }
        //Fluttertoast.showToas(msg: "Sign in success");
        // this.setState(() {
        //   isLoading = false;
        // });
     //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
        Get.off(MyDashBoard());

      } else {
        //Fluttertoast.showToast(msg: "Error: Google Sign In");
        // this.setState(() {
        //   isLoading = false;
        // }
       //);
      }
    }
  }



Swiper imageSlider(context){

  return new Swiper(
    autoplay: true,
    itemBuilder: (BuildContext context, int index) {
      return Container(
          child: Column(
              children: [
                Image.asset('images/MM_logo.png',width:  ScreenUtil().setWidth(70),height:  ScreenUtil().setHeight(67),),
                SizedBox(height: ScreenUtil().setHeight(26)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text('무',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0XFF7EA68D)),),
                      Text('엇이든 ',style: TextStyle(fontSize: ScreenUtil().setSp(28))),
                      Text('물',style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Color(0XFF7EA68D))),
                      Text('어보세요!',style: TextStyle(fontSize: ScreenUtil().setSp(28))),

                    ]),
                Text('''
어디서든 무엇이든
모두가 도움을 주고받을수 있는 ''',maxLines: 20,textAlign: TextAlign.center,style: TextStyle(fontSize: ScreenUtil().setSp(14))),

              ]));
    },
    itemCount: 3,
    viewportFraction: 0.8,
    scale: 0.9,
  );
}












  // FirstPageController homeController = Get.find<FirstPageController>();
  //
  // var tabIndex=0;
  // void changeTabIndex(int index){
  //   tabIndex = index;
  //   update();
  // }
  //
  // @override
  // void onInit() async {
  //   super.onInit();
  // }
  //
  // @override
  // void onReady() {
  //   super.onReady();
  // }
  //
  // @override
  // void onClose() {}
  //
  // void login() async {
  //   CustomFullScreenDialog.showDialog();
  //   GoogleSignInAccount? googleSignInAccount =
  //   await homeController.googleSign.signIn();
  //   if (googleSignInAccount == null) {
  //     CustomFullScreenDialog.cancelDialog();
  //   } else {
  //     GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount.authentication;
  //     OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken);
  //     await homeController.firebaseAuth.signInWithCredential(oAuthCredential);
  //     CustomFullScreenDialog.cancelDialog();
  //   }
  // }
}