import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:skuu_web/pages/index/home.dart';
import 'package:skuu_web/route/routers.dart';
import 'package:skuu_web/themes/skuu_theme_data.dart';


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
          // home:  IpToolPage(),
        );
      },
    );
  }
}
