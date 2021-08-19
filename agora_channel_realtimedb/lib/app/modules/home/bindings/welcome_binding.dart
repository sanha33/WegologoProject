import 'package:get/get.dart';
import 'package:agora_channel_realtimedb/app/modules/home/controllers/welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController());
  }
}