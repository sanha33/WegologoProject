import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_page.dart';
import 'package:getx_bottom_navigation_bar/pages/login/login_page.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';



class FirstPageController extends GetxController {
  late GoogleSignIn googleSign;
  var isSignIn = false.obs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    googleSign = GoogleSignIn();
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = await firebaseAuth.currentUser != null;
    firebaseAuth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });

    super.onReady();
  }

  @override
  void onClose() {}

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      Get.off(()=>MyDashBoard(), arguments: firebaseAuth.currentUser);
    } else {
      Get.off(()=>LoginPage());
    }
  }
}
