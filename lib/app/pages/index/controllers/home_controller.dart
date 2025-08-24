import 'package:flutter/material.dart';
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

  @override
  void onInit() {
    super.onInit();
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
