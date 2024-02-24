import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:skuu/route/router_hander.dart';

class Routes {
  static late FluroRouter router;

//路由管理
  static String root = "/";
  static String chat = "/chat";
  static String friendDetail = "/friend_detail";
  static String userDetail = "/user_detail";
  static String care = "/cares";
  static String collect = "/collects";
  static String watch = "/watchs";
  static String whatArticle = "/look_art";
  static String searchPage = "/search_page";
  static String dateToolPageUrl = "/data_tool_page";
  static String urlToolPageUrl = "/url_tool_page";
  static String idToolPageUrl = "/id_tool_page";
  static String ipToolPageUrl = "/ip_tool_page";
  static String homeItemPageUrl = "/home_item_page";
  static String homeAppbarItemPageUrl = "/home_appbar_item_page";
  static String goodsPageUrl = "/goods_page";
  static String goodsItemUrl = "/goods_item_page";
  static String goodsDetailPageUrl = "/goods_detail_page";
  static String calendarToolPageUrl = "/calendar_tool_page";

  static void configureRoutes(FluroRouter fluroRouter) {
    router = fluroRouter;
    // 未发现对应route
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("route was not found !!!");
      return;
    });
    router.define(root, handler: rootHandler);
    router.define(chat, handler: chathandle);
    router.define(friendDetail, handler: friendDetailhandle);
    router.define(care, handler: carehandle);
    router.define(collect, handler: collecthandle);
    router.define(watch, handler: watchthandle);
    router.define(whatArticle, handler: whatArticlehandle);
    router.define(searchPage, handler: searchPagehandle);
    router.define(userDetail, handler: userDetailPage);
    router.define(dateToolPageUrl, handler: dateToolPageHandler);
    router.define(urlToolPageUrl, handler: urlToolPageHandler);
    router.define(idToolPageUrl, handler: idToolPageHandler);
    router.define(ipToolPageUrl, handler: ipToolPageHandler);
    router.define(homeItemPageUrl, handler: urlHomeItemPageHandler);
    router.define(homeAppbarItemPageUrl, handler: urlHomeAppBarItemPageHandler);
    router.define(goodsPageUrl, handler: urlGoodsPageHandler);
    router.define(goodsDetailPageUrl, handler: goodsDetailPageHandler);
    router.define(calendarToolPageUrl, handler: calendarToolPageHandler);
  }

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  static Future navigateTo(BuildContext context, String path,
      {Map<String, List<dynamic>>? params,
      TransitionType transition = TransitionType.native}) {
    var query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]!.first.toString());
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += '$key=$value';
        index++;
      }
    }
    print('path:$path,params:$query');
    path = path + query;
    return router.navigateTo(context, path, transition: transition);
  }
}
