import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skuu_web/constant/constant.dart';
import 'package:skuu_web/pages/drawer_page.dart';
import 'package:skuu_web/pages/me/myku_page.dart';
import 'package:skuu_web/pages/me/myteams.dart';
import 'package:skuu_web/pages/me/myworks.dart';
import 'package:skuu_web/pages/tool/tool_page.dart';
import 'package:skuu_web/route/routers.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../component/AnimatedBottomBar.dart';
import '../friends/chat_page_list.dart';
import '../friends/friends_page.dart';
import '../me/me_detail_page.dart';
import '../video/myvideo_long_item.dart';
import '../video/myvideo_short_item.dart';
import 'home_item_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = 'skuu';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  String imgPath = 'imgs/';

  late int _selected = 0;

  late bool hasSearch = true;

  List<String> _tabTitle = [];

  late List<Widget> tabBoby;

  late TabController _controller;

  final controller = TextEditingController();

  final List<BarItem> barItems = [
    BarItem(
      text: "首页",
      selectPath: "imgs/index-sel.svg",
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
      selectPath: "imgs/msg-sel.svg",
      unSelectPath: "imgs/msg.svg",
      color: Colors.yellow.shade900,
    ),
    BarItem(
      text: "我的",
      selectPath: "imgs/me-sel.svg",
      unSelectPath: "imgs/me.svg",
      color: Colors.teal,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _changeIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //导航栏
      appBar: getAppbar(),
      drawer: const DrawerPage(),
      body: getTabBar(_tabTitle, tabBoby).values.first,
      floatingActionButton: CircularMenu(
        toggleButtonColor: Colors.lightGreen,
        items: [
          CircularMenuItem(
              color: Colors.lightGreen,
              icon: Icons.add,
              onTap: () {
                // callback
              }),
          CircularMenuItem(
              color: Colors.lightGreen,
              icon: Icons.layers,
              onTap: () {
                setState(() {
                  Constant.LOOK_MODE = false;
                });
              }),
          CircularMenuItem(
              color: Colors.lightGreen,
              icon: Icons.layers_clear,
              onTap: () {
                setState(() {
                  Constant.LOOK_MODE = true;
                });
              }),
          CircularMenuItem(
              color: Colors.lightGreen,
              icon: Icons.settings,
              onTap: () {
                //callback
              }),
        ],
        alignment: Alignment.bottomRight,
      ),
      bottomNavigationBar: Constant.LOOK_MODE
          ? null
          : AnimatedBottomBar(
              barItems: barItems,
              onBarTap: (index) {
                setState(() {
                  _selected = index;
                  _changeIndex(index);
                });
              },
              animationDuration: const Duration(milliseconds: 150),
              barStyle: BarStyle(fontSize: 20.0, iconSize: 30.0),
            ),
    );
  }

  PreferredSizeWidget getAppbar() {
    if (_selected == 0 && hasSearch && !Constant.LOOK_MODE) {
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
      title: getTabBar(_tabTitle, tabBoby).keys.first,
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Routes.navigateTo(context, Routes.searchPage);
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
          Routes.navigateTo(context, Routes.searchPage);
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
      bottom:
          Constant.LOOK_MODE ? null : getTabBar(_tabTitle, tabBoby).keys.first,
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

  //组装tab标题和内容
  Map<TabBar, Widget> getTabBar(List<String> _tabTitle, List<Widget> tabBoby) {
    return {
      TabBar(
        controller: _controller, //控制器
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: _tabTitle.length > 2 ? true : false,
        tabs: _tabTitle.map((e) {
          return Container(
            height: 120.h,
            width: 100.w,
            alignment: Alignment.center,
            child: Text(e),
          );
        }).toList(),
      ): Center(
          child: TabBarView(
        controller: _controller,
        physics: _selected == 2
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(), //禁止滑动
        children: tabBoby,
      ))
    };
  }

  void _changeIndex(int index) {
    setState(() {
      _selected = index;
      if (_selected != 0) {
        hasSearch = true;
      }
      switch (_selected) {
        case 0:
          {
            _tabTitle = [
              '推荐',
              '关注',
              '本地',
              '广场',
              '商场',
              '聚力',
              '共享',
              '工具',
            ];
            tabBoby = [
              HomeItemPage(),
              HomeItemPage(),
              HomeItemPage(),
              MyWorks(),
              MyTeams(),
              HomeItemPage(),
              HomeItemPage(),
              ToolPage()
            ];
            break;
          }
        case 1:
          {
            _tabTitle = [
              '影视',
              '短视频',
            ];
            tabBoby = [
              // AppDeferredWidget(
              //   libraryLoader: myvideo_long_item.loadLibrary,
              //   builder: () => myvideo_long_item.MyVideoLongItem(),
              // ),
              MyVideoLongItem(),
              MyVideoShortItem(),
              // AppDeferredWidget(
              //   libraryLoader: myvideo_short_item.loadLibrary,
              //   builder: () => myvideo_short_item.MyVideoShortItem(),
              // ),
            ];
            break;
          }
        case 2:
          {
            _tabTitle = [
              '消息',
              '好友',
            ];
            tabBoby = [
              ChatPageList(),
              FriendsPage(),
              // AppDeferredWidget(
              //   libraryLoader: chat_page.loadLibrary,
              //   builder: () => chat_page.ChatPage(),
              // ),
              // AppDeferredWidget(
              //   libraryLoader: friends_page.loadLibrary,
              //   builder: () => friends_page.FriendsPage(),
              // ),
            ];
            break;
          }
        case 3:
          {
            _tabTitle = ['UU库', '作品'];
            tabBoby = [
              MykuPage(userId: 12),
              MeDetailPage(12),
              // AppDeferredWidget(
              //   libraryLoader: myworks.loadLibrary,
              //   builder: () => myworks.MyWorks(),
              // ),
              // AppDeferredWidget(
              //   libraryLoader: myteams.loadLibrary,
              //   builder: () => myteams.MyTeams(),
              // ),
            ];
            break;
          }
      }
      _controller = TabController(
        length: _tabTitle.length,
        vsync: this,
      )..addListener(() {
          if (_controller.index.toDouble() == _controller.animation?.value &&
              _selected == 0) {
            if (_controller.index != 0) {
              if (hasSearch) {
                setState(() {
                  hasSearch = false;
                });
              }
            } else {
              if (!hasSearch) {
                setState(() {
                  hasSearch = true;
                });
              }
            }
          }
        });
    });
  }

  _launchURL(url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
