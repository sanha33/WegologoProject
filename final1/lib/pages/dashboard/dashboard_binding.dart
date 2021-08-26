import 'package:get/get.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard_controller.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_controller.dart';
import 'package:getx_bottom_navigation_bar/pages/mypage/mypage_controller.dart';
import 'package:getx_bottom_navigation_bar/pages/first/first_controller.dart';
import 'package:getx_bottom_navigation_bar/pages/login/login_controller.dart';


class DashBoardBinding extends Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<LoginPageController>(() => LoginPageController());
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.lazyPut<HomePageController>(() => HomePageController());
    Get.lazyPut<MyPageController>(() => MyPageController());
 //   Get.lazyPut<FirstPageController>(() => FirstPageController());

  //  Get.lazyPut<AddPageController>(() => AddPageController());
  }
}