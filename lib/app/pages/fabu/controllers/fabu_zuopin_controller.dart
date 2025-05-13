import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/fabu/views/fabu_goods_page.dart';

import '../views/fabu_aixin_page.dart';
import '../views/fabu_dynamic_page.dart';
import '../views/fabu_video_page.dart';

class FabuZuoPinController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //tab控制
  late TabController tabController;
  late List<String> tabTitle = [
    '发布动态',
    '发布视频',
    '发布商品',
    '发布爱心',
  ];
  late List<Widget> tabBoby = [
    FabuDynamicPage(),
    FabuVideoPage(),
    FabuGoodsPage(),
    FabuAiXinPage(),
  ];

  @override
  void onInit() {
    tabController = TabController(
      length: tabTitle.length,
      vsync: this,
    );
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose(); // 清理 TabController
    super.onClose();
  }
}
