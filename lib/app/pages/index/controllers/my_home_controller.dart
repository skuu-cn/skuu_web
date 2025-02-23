import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/constants.dart';
import '../../../components/AnimatedBottomBar.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../friends/chat_page_list.dart';
import '../../friends/friends_page.dart';
import '../../goods/goods_page.dart';
import '../../me/me_detail_page.dart';
import '../../me/myku_page.dart';
import '../../me/myworks.dart';
import '../../tool/tool_page.dart';
import '../../video/myvideo_long_item.dart';
import '../../video/short_video_player/homepage/short_video_homepage.dart';
import '../views/help_item_page.dart';
import '../views/home_item_page.dart';

class MyHomeController extends GetxController {
  List<dynamic>? data;

  // late List<MenusEntity> menus;
  String imgPath = 'imgs/';

  late int selected = 0;

  late bool hasSearch = true;

  late List<String> tabTitle = [];

  late List<Widget> tabBoby;

  final controller = TextEditingController();

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
  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  @override
  void onInit() {
    // getDataLocal();
    super.onInit();
  }

  // getDataLocal() async {
  //   final response = await rootBundle.loadString('mock/menus.json');
  //   List<dynamic> jsonList = jsonDecode(response);
  //   menus = jsonList.map((json) => MenusEntity.fromJson(json)).toList();
  // }

  // getting data from api
  getDataFromApi() async {
    // *) perform api call
    await BaseClient.safeApiCall(
      Constants.todosApiUrl, // url
      RequestType.get, // request type (get,post,delete,put)
      onLoading: () {
        // *) indicate loading state
        apiCallStatus = ApiCallStatus.loading;
        update();
      },
      onSuccess: (response) {
        // api done successfully
        data = List.from(response.data);
        // *) indicate success state
        apiCallStatus = ApiCallStatus.success;
        update();
      },
      // if you don't pass this method base client
      // will automaticly handle error and show message to user
      onError: (error) {
        // show error message to user
        BaseClient.handleApiError(error);
        // *) indicate error status
        apiCallStatus = ApiCallStatus.error;
        update();
      },
    );
  }

  void changeIndex(int index) {
    selected = index;
    switch (selected) {
      case 0:
        {
          tabTitle = [
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
            GoodsPage(),
            HelpItemPage(),
            HelpItemPage(),
            ToolPage()
          ];
          break;
        }
      case 1:
        {
          tabTitle = [
            '影视',
            '短视频',
          ];
          tabBoby = [
            MyVideoLongItem(),
            ShortVideoHomePage(),
          ];
          break;
        }
      case 2:
        {
          tabTitle = [
            '消息',
            '好友',
          ];
          tabBoby = [
            ChatPageList(),
            FriendsPage(),
          ];
          break;
        }
      case 3:
        {
          tabTitle = ['UU库', '作品'];
          tabBoby = [
            MykuPage(userId: 12),
            MeDetailPage(12),
          ];
          break;
        }
    }
    update();
  }
}
