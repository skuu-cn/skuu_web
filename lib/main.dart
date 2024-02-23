import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skuu/pages/index/home.dart';
import 'package:skuu/pages/tool/tool_page.dart';
import 'package:skuu/route/routers.dart';
import 'package:skuu/themes/skuu_theme_data.dart';

import 'demo/flickvideo/feed_player/feed_player.dart';
import 'demo/flickvideo/flick_video_player.dart';
import 'demo/flickvideo/short_video_player/homepage/short_video_homepage.dart';
import 'demo/flickvideo/short_video_player/short_video_player/short_video_player.dart';



void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  initializeDateFormatting().then((_) => runApp(MyApp()));
  // ;runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(360, 690),
      designSize: const Size(1170, 2532),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'skuu',
          debugShowCheckedModeBanner: false,
          theme: SkuuThemeData.lightThemeData.copyWith(),
          home: const MyHomePage(),
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          supportedLocales: const [
            Locale('en', ''),
            Locale('zh', ''),
          ],
          // home: ShortVideoHomePage()
        );
      },
    );
  }
}
