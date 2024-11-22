import 'package:file_selector/file_selector.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:skuu/pages/friends/chat_pagev2.dart' deferred as chat_pagev2;
import 'package:skuu/pages/lookart/look_art_page.dart'
    deferred as look_art_page;

import '../cache/deferred_widget.dart';
import '../pages/friends/friend_detail.dart' deferred as friend_detail;
import '../pages/friends/user_detail_page.dart' deferred as user_detail_page;
import '../pages/goods/goods_detail_page.dart' deferred as goods_detail_page;
import '../pages/goods/shop_page.dart' deferred as shop_page;
import '../pages/index/home.dart';
import '../pages/index/home_appbar_item_page.dart'
    deferred as home_appbar_item_page;
import '../pages/index/home_item_page.dart' deferred as home_item_page;
import '../pages/meleft/mycare_page.dart' deferred as mycare_page;
import '../pages/meleft/mycollect_page.dart' deferred as mycollect_page;
import '../pages/search/search_page.dart' deferred as search_page;
import '../pages/tool/calendar_tool_page.dart' deferred as calendar_tool_page;
import '../pages/tool/date_tool_page.dart' deferred as date_tool_pagedef;
import '../pages/tool/id_tool_page.dart' deferred as id_tool_pagedef;
import '../pages/tool/qr_code_page.dart' deferred as qr_code_pagedef;
import '../pages/tool/ip_tool_page.dart' deferred as ip_tool_pagedef;
import '../pages/tool/url_tool_page.dart' deferred as url_tool_pagedef;
import '../pages/watchvideo/play_video_page.dart' deferred as play_video_page;
import '../pages/public/public_dynamic_page.dart'
    deferred as public_dynamic_page;
import '../pages/public/public_video_page.dart' deferred as public_video_page;
import '../pages/public/public_short_video_page.dart'
    deferred as public_short_video_page;
import '../pages/public/public_goods_page.dart' deferred as public_goods_page;
import '../pages/tool/ai_page.dart' deferred as ai_page;

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return MyHomePage();
});
var chathandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  var title = params['chatId']!.first;
  return AppDeferredWidget(
    libraryLoader: chat_pagev2.loadLibrary,
    builder: () => chat_pagev2.ChatPageV2(
      chatId: int.parse(title),
    ),
  );
});
var friendDetailhandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String title = params['title']!.first;
  // return FriendDetail(title: title);
  return AppDeferredWidget(
    libraryLoader: friend_detail.loadLibrary,
    builder: () => friend_detail.FriendDetail(title: title),
  );
});
var carehandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return MyCarePage();
  return AppDeferredWidget(
    libraryLoader: mycare_page.loadLibrary,
    builder: () => mycare_page.MyCarePage(),
  );
});
var collecthandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return MyCollectPage();
  return AppDeferredWidget(
    libraryLoader: mycollect_page.loadLibrary,
    builder: () => mycollect_page.MyCollectPage(),
  );
});
var watchthandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return PlayVideoPage();
  return AppDeferredWidget(
    libraryLoader: play_video_page.loadLibrary,
    builder: () => play_video_page.PlayVideoPage(),
  );
});
var whatArticlehandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return WhatArticle();

  return AppDeferredWidget(
    libraryLoader: look_art_page.loadLibrary,
    builder: () => look_art_page.LookArticalPage(),
  );
});
var searchPagehandle = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  // return SearchPage();
  return AppDeferredWidget(
    libraryLoader: search_page.loadLibrary,
    builder: () => search_page.SearchPage(),
  );
});
var userDetailPage = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  var userId = params['userId']!.firstOrNull;
  var showAppBar = params['showAppBar']!.firstOrNull;
  return AppDeferredWidget(
    libraryLoader: user_detail_page.loadLibrary,
    builder: () => user_detail_page.UserDetailPage(
        int.parse(userId), bool.parse(showAppBar)),
  );
});

var dateToolPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: date_tool_pagedef.loadLibrary,
    builder: () => date_tool_pagedef.DateToolPage(),
  );
});
var urlToolPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: url_tool_pagedef.loadLibrary,
    builder: () => url_tool_pagedef.UrlToolPage(),
  );
});

var idToolPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: id_tool_pagedef.loadLibrary,
    builder: () => id_tool_pagedef.IdToolPage(),
  );
});
var qrCodePageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: qr_code_pagedef.loadLibrary,
    builder: () => qr_code_pagedef.QrCodePage(),
  );
});

var ipToolPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: ip_tool_pagedef.loadLibrary,
    builder: () => ip_tool_pagedef.IpToolPage(),
  );
});

var urlHomeItemPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: home_item_page.loadLibrary,
    builder: () => home_item_page.HomeItemPage(),
  );
});

var urlHomeAppBarItemPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: home_appbar_item_page.loadLibrary,
    builder: () => home_appbar_item_page.HomeAppBarItemPage(),
  );
});

var urlGoodsPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: shop_page.loadLibrary,
    builder: () => shop_page.ShopPage(),
  );
});

var goodsDetailPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: goods_detail_page.loadLibrary,
    builder: () => goods_detail_page.GoodsDetailPage(),
  );
});

var calendarToolPageHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<dynamic>> params) {
  return AppDeferredWidget(
    libraryLoader: calendar_tool_page.loadLibrary,
    builder: () => calendar_tool_page.CalendarToolPage(),
  );
});
var publishDynamicPageUrlHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AppDeferredWidget(
    libraryLoader: public_dynamic_page.loadLibrary,
    builder: () => public_dynamic_page.PublicDynamicPage(),
  );
});
var publishVideoPageUrlHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AppDeferredWidget(
    libraryLoader: public_video_page.loadLibrary,
    builder: () => public_video_page.PublicVideoPage(),
  );
});
var publishShortVideoPageUrlHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AppDeferredWidget(
    libraryLoader: public_short_video_page.loadLibrary,
    builder: () => public_short_video_page.PublicShortVideoPage(),
  );
});
var publishGoodsPageUrlHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return AppDeferredWidget(
    libraryLoader: public_goods_page.loadLibrary,
    builder: () => public_goods_page.PublicGoodsPage(),
  );
});

var aiPageUrlHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      return AppDeferredWidget(
        libraryLoader: ai_page.loadLibrary,
        builder: () => ai_page.AiPage(),
      );
    });
