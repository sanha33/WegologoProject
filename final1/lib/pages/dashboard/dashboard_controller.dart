import 'package:get/get.dart';
import 'package:getx_bottom_navigation_bar/pages/first/first_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_bottom_navigation_bar/pages/login/login_controller.dart';

class DashBoardController extends GetxController{
  var tabIndex=0;
  void changeTabIndex(int index){
    tabIndex = index;
    update();
  }


  LoginPageController firstController = Get.find<LoginPageController>();


  //FirstPageController firstController = Get.find<FirstPageController>();
  late User user;

  @override
  void onInit() async {
    super.onInit();
    user = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void logout() async {
    await firstController.googleSignIn.disconnect();
    await firstController.firebaseAuth.signOut();
  }
}