import 'package:get/get.dart';
import 'package:skuu/app/pages/demo/getx/controllers/demo_controller.dart';
import 'package:skuu/app/pages/lookart/controllers/look_art_controller.dart';

class LoogArtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LookArtController());
  }
}
