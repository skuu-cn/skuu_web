import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexController extends GetxController with GetTickerProviderStateMixin {
  final RxBool hasSearch = true.obs;

  final tabTitle = <String>[].obs;

  late TabController tabController;

  late TextEditingController controller = TextEditingController();

  @override
  void onInit() {
    initTabView();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getTabviewMenu() {
    tabTitle.value = [
      '推荐',
      '关注',
      '本地',
      '广场',
      '商场',
      '聚力',
      '共享',
      '工具',
    ];
  }

  void changeShowSearch(bool ifShow) {
    if (hasSearch.value != ifShow) {
      hasSearch.value = ifShow;
    }
  }

  void initTabView() {
    getTabviewMenu();
    tabController = TabController(
      length: tabTitle.length,
      vsync: this,
    )..addListener(() {
        //搜索框
        if (tabController.index == 0) {
          hasSearch.value = true;
        } else {
          hasSearch.value = false;
        }
      });
  }

  @override
  void onClose() {
    tabController.dispose();
    controller.dispose();
    super.onClose();
  }
}
