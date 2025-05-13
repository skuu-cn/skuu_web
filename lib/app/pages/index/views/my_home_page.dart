import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/drawer_page.dart';
import 'package:skuu/app/pages/index/controllers/my_home_controller.dart';
import 'package:skuu/app/pages/index/views/widgets/slide_transition_x.dart';
import 'package:skuu/constant/color_constant.dart';
import 'package:skuu/constant/constant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/AnimatedBottomBar.dart';
import '../../../routes/app_pages.dart';

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
        floatingActionButton: 1.sw <= 500
            ? null
            : CircularMenu(
                toggleButtonColor: ColorConstant.ThemeGreen,
                items: [
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.home,
                      onTap: () {
                        changeIndex(0);
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.slow_motion_video_sharp,
                      onTap: () {
                        changeIndex(1);
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.message,
                      onTap: () {
                        changeIndex(2);
                      }),
                  CircularMenuItem(
                      color: ColorConstant.ThemeGreen,
                      icon: Icons.people,
                      onTap: () {
                        changeIndex(3);
                      }),
                ],
                alignment: Alignment.bottomRight,
              ),
        bottomNavigationBar: 1.sw <= 500
            ? AnimatedBottomBar(
                barItems: controller.barItems,
                onBarTap: (index) {
                  changeIndex(index);
                },
                animationDuration: const Duration(milliseconds: 150),
                barStyle: BarStyle(fontSize: 15.0, iconSize: 20.0),
              )
            : null,
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
    if (controller.selected == 0) {
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
          icon: Icon(Icons.add),
          onPressed: () {
            Get.toNamed(Routes.publishZuoPinPageUrl);
            // showModalBottomSheet(
            //     constraints: BoxConstraints(maxHeight: 350.h),
            //     context: context,
            //     builder: (BuildContext build) {
            //       return PublicSheets();
            //     });
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
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
        return SlideTransitionX(
          child: child,
          direction: AxisDirection.down, //上入下出
          position: animation,
        );
      },
      child: controller.hasSearch
          ? InkWell(
              onTap: () {
                Get.toNamed(Routes.searchPage);
              },
              child: Container(
                  width: 0.8.sw,
                  height: 40,
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.search),
                      label: Text("英雄联盟手游"))),
            )
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
    );
  }

  Widget animateActions() {
    return AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        transitionBuilder: (Widget child, Animation<double> animation) {
          var tween = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0));
          return SlideTransitionX(
            child: child,
            direction: AxisDirection.down, //上入下出
            position: animation,
          );
        },
        child: controller.hasSearch
            ? Container(
                width: 100,
                child: TextButton(
                  child: Text(
                    '京ICP备2022023998号-2',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                  onPressed: () {
                    _launchURL(Uri(scheme: 'https', host: 'beian.miit.gov.cn'));
                  },
                ),
              )
            : Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle_sharp),
                    onPressed: () {
                      Get.toNamed(Routes.publishZuoPinPageUrl);

                      // showModalBottomSheet(
                      //     constraints: BoxConstraints(maxHeight: 350.h),
                      //     context: context,
                      //     builder: (BuildContext build) {
                      //       return PublicSheets();
                      //     });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Get.toNamed(Routes.searchPage);
                    },
                  )
                ],
              ));
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
      title: animatedTitle(),
      actions: [animateActions()],
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
