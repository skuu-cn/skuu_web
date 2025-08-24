import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/index/controllers/video_controller.dart';

import '../../../routes/app_pages.dart';
import '../../demo/flickvideo/short_video_player/homepage/short_video_homepage.dart';
import '../../demo/flickvideo/short_video_player/short_video_player/short_video_player.dart';
import '../../drawer_page.dart';
import '../../video/views/long_video_view.dart';

class VideoPage extends GetView<VideoController> {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        //导航栏
        appBar: getAppbar2(),
        drawer: const DrawerPage(),
        body: Center(
            child: TabBarView(
          controller: controller.tabController,
          physics: const AlwaysScrollableScrollPhysics(), //禁止滑动
          children: [
            LongVideoView(),
            ShortVideoPlayer(),
          ],
        )),
      );
    });
  }

  PreferredSizeWidget getAppbar2() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            child: Image.asset(
              'imgs/hy.gif',
            ),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      automaticallyImplyLeading: false,
      title: TabBar(
          controller: controller.tabController,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: controller.tabTitle.length > 2,
          tabs: controller.tabTitle.map((e) {
            return Container(
              height: 120.h,
              width: 100.w,
              alignment: Alignment.center,
              child: Text(e),
            );
          }).toList()),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Get.toNamed(Routes.publishZuoPinPageUrl);
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Get.toNamed(Routes.searchPage);
          },
        )
      ],
    );
  }

  Widget animatedTitle() {
    return TabBar(
        controller: controller.tabController,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: controller.tabTitle.length > 2 ? true : false,
        tabs: controller.tabTitle.map((e) {
          return Container(
            height: 120.h,
            width: 100.w,
            alignment: Alignment.center,
            child: Text(e),
          );
        }).toList());
  }

  Widget animateActions() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.add_circle_sharp),
          onPressed: () {
            Get.toNamed(Routes.publishZuoPinPageUrl);
          },
        ),
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Get.toNamed(Routes.searchPage);
          },
        )
      ],
    );
  }
}
