import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:getx_bottom_navigation_bar/pages/first/first_controller.dart';
import 'package:getx_bottom_navigation_bar/navigation/customFullScreenDialog.dart';


class LoginPageController extends GetxController {
  FirstPageController homeController = Get.find<FirstPageController>();

  var tabIndex=0;
  void changeTabIndex(int index){
    tabIndex = index;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void login() async {
    CustomFullScreenDialog.showDialog();
    GoogleSignInAccount? googleSignInAccount =
    await homeController.googleSign.signIn();
    if (googleSignInAccount == null) {
      CustomFullScreenDialog.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await homeController.firebaseAuth.signInWithCredential(oAuthCredential);
      CustomFullScreenDialog.cancelDialog();
    }
  }
}