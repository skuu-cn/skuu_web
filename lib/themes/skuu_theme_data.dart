// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/color_constant.dart';

class SkuuThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        // fontFamily: "AlibabaPuHuiTi",
        colorScheme: colorScheme,
        textTheme: _textTheme.useSystemChineseFont(Brightness.light),
        appBarTheme: AppBarTheme(
          backgroundColor: ColorConstant.lightBlue,
          elevation: 0,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // iconTheme: IconThemeData(color: colorScheme.onPrimary),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.lightGreen,
          // height: 50
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(shape: CircleBorder(), elevation: 5),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.lightGreen,
          width: 400,
          insetPadding: EdgeInsets.only(bottom: 0.2.sh, left: 200.w),
          contentTextStyle: _textTheme.titleMedium!
              .apply(color: _darkFillColor)
              .useSystemChineseFont(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
        popupMenuTheme: PopupMenuThemeData(surfaceTintColor: Colors.white),
        tabBarTheme: TabBarTheme(labelColor: ColorConstant.ThemeGreen)
        // elevatedButtonTheme: elevatedButtonTheme
        );
  }

  // static const ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  // );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.black54,
    primaryContainer: Color(0xFF117378),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFFFAFBFB),
    // background: Color(0xFFE6EBEB),
    background: Colors.white,
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryContainer: Color(0xFF1CDEC9),
    secondary: Color(0xFF4D1F7C),
    secondaryContainer: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  // static const _regular = FontWeight.w400;
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    bodySmall: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    titleMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    titleSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    titleLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    labelLarge: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );
  static final TextTheme _textTheme1 = TextTheme(
    headlineMedium:
        TextStyle(fontFamily: "AlibabaPuHuiTi", fontWeight: _bold, fontSize: 20.0),
    bodySmall: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _semiBold, fontSize: 16.0),
    headlineSmall: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _medium, fontSize: 16.0),
    titleMedium: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _medium, fontSize: 16.0),
    labelSmall: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _medium, fontSize: 12.0),
    bodyLarge: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _regular, fontSize: 14.0),
    titleSmall: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _medium, fontSize: 14.0),
    bodyMedium: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _regular, fontSize: 16.0),
    titleLarge:
        TextStyle(fontFamily: "AlibabaPuHuiTi", fontWeight: _bold, fontSize: 16.0),
    labelLarge: TextStyle(
        fontFamily: "AlibabaPuHuiTi", fontWeight: _semiBold, fontSize: 14.0),
  );
}
