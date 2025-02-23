import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/drawer_page.dart';
import 'package:skuu/app/pages/index/controllers/my_home_controller.dart';
import 'package:skuu/app/pages/index/views/widgets/public_sheets.dart';
import 'package:skuu/constant/color_constant.dart';
import 'package:skuu/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/AnimatedBottomBar.dart';
import '../../../routes/app_pages.dart';
import 'filter_page.dart';
import 'goods_filter_pagev2.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> with TickerProviderStateMixin {
  late MyHomeController controller;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    // 获取 GetX 控制器
    controller = Get.put(MyHomeController());
    changeIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyHomeController>(builder: (a) {
      return Scaffold(
        //导航栏
        appBar: getAppbar(),
        drawer: const DrawerPage(),
        body: Center(
            child: TabBarView(
          controller: tabController,
          physics:
              (controller.selected == 2 && 1.sw >= Constant.CHAT_TWO_VIEW_WIDTH)
                  ? const NeverScrollableScrollPhysics()
                  : const AlwaysScrollableScrollPhysics(), //禁止滑动
          children: controller.tabBoby,
        )),
        floatingActionButton: controller.selected != 0
            ? null
            : CircularMenu(
                toggleButtonColor: ColorConstant.ThemeGreen,
                items: [
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.add,
                      onTap: () {
                        showModalBottomSheet(
                            constraints: BoxConstraints(maxHeight: 350.h),
                            context: context,
                            builder: (BuildContext build) {
                              return PublicSheets();
                            });
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.layers,
                      onTap: () {
                        setState(() {
                          Constant.LOOK_MODE = false;
                        });
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.layers_clear,
                      onTap: () {
                        setState(() {
                          Constant.LOOK_MODE = true;
                        });
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.filter_alt,
                      onTap: () {
                        showModalBottomSheet(
                            constraints: BoxConstraints(maxHeight: 0.8.sh),
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext build) {
                              if (tabController.index == 4)
                                return GoodsFilterPageV2();
                              return FilterPage([]);
                            }).then((value) => {print(value)});
                        //callback
                      }),
                ],
                alignment: Alignment.bottomRight,
              ),
        bottomNavigationBar: Constant.LOOK_MODE
            ? null
            : AnimatedBottomBar(
                barItems: controller.barItems,
                onBarTap: (index) {
                  changeIndex(index);
                },
                animationDuration: const Duration(milliseconds: 150),
                barStyle: BarStyle(fontSize: 15.0, iconSize: 20.0),
              ),
      );
    });
  }

  void changeIndex(int index) {
    controller.changeIndex(index);
    tabController = TabController(
      length: controller.tabTitle.length,
      vsync: this,
    )..addListener(() {
        //搜索框
        if (controller.selected == 0) {
          if (tabController.index == 0) {
            controller.hasSearch = true;
          } else {
            controller.hasSearch = false;
          }
        }
      });
  }

  PreferredSizeWidget getAppbar() {
    if (controller.selected == 0 &&
        controller.hasSearch &&
        !Constant.LOOK_MODE) {
      return getAppbar1();
    } else {
      return getAppbar2();
    }
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
      // centerTitle: false,
      title: TabBar(
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: controller.tabTitle.length > 2 ? true : false,
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
          icon: Icon(Icons.search),
          onPressed: () {
            Get.toNamed(Routes.searchPage);
          },
        )
      ],
    );
  }

  PreferredSizeWidget getAppbar1() {
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
      // centerTitle: false,
      title: InkWell(
        onTap: () {
          Get.toNamed(Routes.searchPage);
        },
        child: Container(
            width: 0.8.sw,
            height: 40,
            margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.search),
                label: Text("英雄联盟手游"))),
      ),
      bottom: Constant.LOOK_MODE
          ? null
          : TabBar(
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: controller.tabTitle.length > 2 ? true : false,
              tabs: controller.tabTitle.map((e) {
                return Container(
                  height: 120.h,
                  width: 100.w,
                  alignment: Alignment.center,
                  child: Text(e),
                );
              }).toList()),
      actions: [
        Container(
          width: 100,
          child: TextButton(
            child: Text(
              '京ICP备2022023998号',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
            onPressed: () {
              _launchURL(Uri(scheme: 'https', host: 'beian.miit.gov.cn'));
            },
          ),
        )
      ],
    );
  }

  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
