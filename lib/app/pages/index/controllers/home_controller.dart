import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/index/views/index_page.dart';
import 'package:skuu/app/pages/index/views/me_page.dart';
import 'package:skuu/app/pages/index/views/message_page.dart';
import 'package:skuu/app/pages/index/views/video_page.dart';

import '../../../components/AnimatedBottomBar.dart';

class HomeController extends GetxController {
  List<dynamic>? data;

  String imgPath = 'imgs/';
  final selected = 0.obs;
  final bottomMenuType = 1.obs;
  final tabTitle = <String>[].obs;
  final tabBoby = <Widget>[].obs;
  final colCount = 2.obs;

  final Rx<Offset> fabOffset = Offset.zero.obs;
  final RxDouble fabSize = 56.0.obs;
  final RxBool isDragging = false.obs;

  // 定义一个工厂函数列表，而不是实例列表
  final List<Widget Function()> mainPageBuilders = [
    () => IndexPage(),
    () => VideoPage(),
    () => MessagePage(),
    () => MePage(),
  ];

// 在 changeMainPage 中
  void changeMainPage(int index) {
    if (index >= 0 && index < mainPageBuilders.length) {
      selected.value = index;
    }
  }

  final List<BarItem> barItems = [
    BarItem(
      text: "首页",
      selectPath: "imgs/index-selv2.svg",
      unSelectPath: "imgs/index.svg",
      color: Colors.indigo,
    ),
    BarItem(
      text: "影视",
      selectPath: "imgs/video-sel.svg",
      unSelectPath: "imgs/video.svg",
      color: Colors.purple,
    ),
    BarItem(
      text: "消息",
      selectPath: "imgs/msg-selv2.svg",
      unSelectPath: "imgs/msg.svg",
      color: Colors.yellow.shade900,
    ),
    BarItem(
      text: "我的",
      selectPath: "imgs/me-selv2.svg",
      unSelectPath: "imgs/me.svg",
      color: Colors.teal,
    ),
  ];

  void setColCount(double len) {
    if (len < 1000) {
      colCount.value = 1;
    } else {
      colCount.value = 2;
    }
  }

  void onDragStart(DragStartDetails details) {
    isDragging.value = true;
  }

  void onDragUpdate(DragUpdateDetails details) {
    final minX = 0.0;
    final maxX = 1.sw - fabSize.value;
    final minY = MediaQuery.of(Get.context!).padding.top;
    final maxY = 1.sh - fabSize.value - MediaQuery.of(Get.context!).padding.bottom;
    fabOffset.value = Offset(
      (fabOffset.value.dx + details.delta.dx).clamp(minX, maxX),
      (fabOffset.value.dy + details.delta.dy).clamp(minY, maxY),
    );
  }

  void onDragEnd(DragEndDetails details) {
    isDragging.value = false;
    final double midScreenX = 1.sw / 2;
    final double margin = 16.0;
    final double endX = fabOffset.value.dx < midScreenX ? margin : 1.sw - fabSize.value - margin;
    final minY = MediaQuery.of(Get.context!).padding.top + margin;
    final maxY = 1.sh - fabSize.value - MediaQuery.of(Get.context!).padding.bottom - margin;
    fabOffset.value = Offset(endX, fabOffset.value.dy.clamp(minY, maxY));
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenSize = Get.size;
      final padding = Get.mediaQuery.padding;
      fabSize.value = 56.0.w;
      fabOffset.value = Offset(
        screenSize.width - fabSize.value - 116.w,
        screenSize.height - fabSize.value - padding.bottom - 116.h,
      );
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
