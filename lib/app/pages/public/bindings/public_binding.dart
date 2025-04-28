import 'package:get/get.dart';
import 'package:skuu/app/pages/public/controllers/public_dynamic_controller.dart';
import 'package:skuu/app/pages/public/views/public_dynamic_page.dart';

class PublicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PublicDynamicController>(
      () => PublicDynamicController(),
    );
  }
}
