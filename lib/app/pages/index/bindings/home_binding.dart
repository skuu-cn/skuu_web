import 'package:get/get.dart';
import 'package:skuu/app/pages/index/controllers/home_controller.dart';

import '../../blog/controllers/blog_controller.dart';
import '../../blog/data/blog_repo.dart';
import '../../blog/data/iblog_page_provider.dart';
import '../../video/controllers/long_video_controller.dart';
import '../controllers/index_controller.dart';
import '../controllers/me_controller.dart';
import '../controllers/message_controller.dart';
import '../controllers/video_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => VideoController());
    Get.lazyPut(() => MessageController());
    Get.lazyPut(() => MeController());

    Get.lazyPut<IBlogPageProvider>(() => BlogPageProvider());
    Get.lazyPut<BlogRepo>(
        () => BlogRepo(provider: Get.find<IBlogPageProvider>()));
    Get.lazyPut<BlogController>(
        () => BlogController(blogPageRepo: Get.find<BlogRepo>()));

    Get.lazyPut(() => LongVideoController());

  }
}
