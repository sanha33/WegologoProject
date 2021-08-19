import 'package:get/get.dart';
import 'package:agora_channel_realtimedb/app/modules/home/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}