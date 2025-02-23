import 'package:get/get.dart';
import 'package:skuu/app/pages/index/controllers/my_home_controller.dart';

class MyHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyHomeController());
  }
}
