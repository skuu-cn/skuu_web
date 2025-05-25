import 'package:get/get.dart';
import 'package:skuu/app/pages/fabu/bindings/fabu_dynamic_binding.dart';
import 'package:skuu/app/pages/fabu/bindings/fabu_video_binding.dart';
import 'package:skuu/app/pages/friends/chat_pagev2.dart';
import 'package:skuu/app/pages/friends/friends_page.dart';
import 'package:skuu/app/pages/friends/user_detail_page.dart';
import 'package:skuu/app/pages/goods/goods_detail_page.dart';
import 'package:skuu/app/pages/goods/goods_page.dart';
import 'package:skuu/app/pages/index/bindings/my_home_binding.dart';
import 'package:skuu/app/pages/index/views/home_appbar_item_page.dart';
import 'package:skuu/app/pages/index/views/home_item_page.dart';
import 'package:skuu/app/pages/lookart/look_art_page.dart';
import 'package:skuu/app/pages/meleft/mycare_page.dart';
import 'package:skuu/app/pages/meleft/mycollect_page.dart';
import 'package:skuu/app/pages/tool/ai_page.dart';
import 'package:skuu/app/pages/tool/bindings/tool_binding.dart';
import 'package:skuu/app/pages/tool/calendar_tool_page.dart';
import 'package:skuu/app/pages/tool/date_tool_page.dart';
import 'package:skuu/app/pages/tool/id_tool_page.dart';
import 'package:skuu/app/pages/tool/ip_tool_page.dart';
import 'package:skuu/app/pages/tool/qr_code_page.dart';
import 'package:skuu/app/pages/tool/thumbnail_page.dart';
import 'package:skuu/app/pages/tool/url_tool_page.dart';
import 'package:skuu/app/pages/weather/views/perday_weather_view.dart';
import 'package:skuu/app/pages/weather/weather_home_page.dart';

import '../pages/fabu/bindings/fabu_zuopin_binding.dart';
import '../pages/fabu/views/fabu_dynamic_page.dart';
import '../pages/fabu/views/fabu_goods_page.dart';
import '../pages/fabu/views/fabu_short_video_page.dart';
import '../pages/fabu/views/fabu_video_page.dart';
import '../pages/fabu/views/fabu_zuopin_page.dart';
import '../pages/index/views/my_home_page.dart';
import '../pages/search/search_page.dart';
import '../pages/watchvideo/play_video_page.dart';
import '../pages/weather/bindings/weather_binding.dart';
import '../pages/weather/weather_detail_view.dart';
import '../pages/weather/weather_left_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => MyHomePage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.searchPage,
      page: () => SearchPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.aiPageUrl,
      page: () => AiPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.qrCodePageUrl,
      page: () => QrCodePage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.calendarToolPageUrl,
      page: () => CalendarToolPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.care,
      page: () => MyCarePage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.chat,
      page: () => ChatPageV2(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.collect,
      page: () => MyCollectPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.dateToolPageUrl,
      page: () => DateToolPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.friendDetail,
      page: () => FriendsPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.goodsDetailPageUrl,
      page: () => GoodsDetailPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.goodsPageUrl,
      page: () => GoodsPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.idToolPageUrl,
      page: () => IdToolPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.urlToolPageUrl,
      page: () => UrlToolPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.homeAppbarItemPageUrl,
      page: () => HomeAppBarItemPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.userDetail,
      page: () => UserDetailPage(Get.parameters['userId'] as int,
          Get.parameters['showAppBar'] as bool),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.watchVideo,
      page: () => PlayVideoPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.whatArticle,
      page: () => LookArticalPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.ipToolPageUrl,
      page: () => IpToolPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.homeItemPageUrl,
      page: () => HomeItemPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.homeAppbarItemPageUrl,
      page: () => HomeAppBarItemPage(),
      binding: MyHomeBinding(),
    ),

    GetPage(
      name: Routes.publishGoodsPageUrl,
      page: () => FabuGoodsPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.aiPageUrl,
      page: () => AiPage(),
      binding: MyHomeBinding(),
    ),
    GetPage(
      name: Routes.thumbnailPageUrl,
      page: () => ThumbnailPage(),
      binding: ToolBing(),
    ),
    GetPage(
      name: Routes.publishZuoPinPageUrl,
      page: () => FabuZuoPinPage(),
      binding: FabuZuoPinBinding(),
    ),
    GetPage(
      name: Routes.weatherPageUrl,
      page: () => WeatherHomePage(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: Routes.weatherLeftPageUrl,
      page: () => WeatherLeftPage(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: Routes.weatherRightPageUrl,
      page: () => WeatherDetailView(),
      binding: WeatherBinding(),
    ),
    GetPage(
      name: Routes.weatherRightPageUrl,
      page: () => PerDayWeatherView(),
      binding: WeatherBinding(),
    ),
  ];
}
