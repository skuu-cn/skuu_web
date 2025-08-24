import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/index/controllers/home_controller.dart';
import 'package:skuu/constant/color_constant.dart';

import '../../../components/AnimatedBottomBar.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        //导航栏
        body: controller.mainPageBuilders[controller.selected.value](),
        floatingActionButton: 1.sw <= 500
            ? null
            : CircularMenu(
                toggleButtonColor: ColorConstant.ThemeGreen,
                items: [
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.home,
                      onTap: () {
                        controller.changeMainPage(0);
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.slow_motion_video_sharp,
                      onTap: () {
                        controller.changeMainPage(1);
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.message,
                      onTap: () {
                        controller.changeMainPage(2);
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.people,
                      onTap: () {
                        controller.changeMainPage(3);
                      }),
                ],
                alignment: Alignment.bottomRight,
              ),
        bottomNavigationBar: 1.sw <= 500
            ? SafeArea(
                child: AnimatedBottomBar(
                barItems: controller.barItems,
                onBarTap: (index) {
                  controller.changeMainPage(index);
                },
                animationDuration: const Duration(milliseconds: 150),
                barStyle: BarStyle(fontSize: 15.0, iconSize: 20.0),
              ))
            : null,
      );
    });
  }
}
