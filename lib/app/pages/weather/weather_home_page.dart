import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/weather/controllers/weather_controller.dart';
import 'package:skuu/app/pages/weather/weather_detail_view.dart';
import 'package:skuu/app/pages/weather/weather_left_page.dart';

import '../demo/weather/page_view.dart';

class WeatherHomePage extends GetView<WeatherController> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                  width: 0.8.sw,
                  height: 40,
                  margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.w),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "快速搜索",
                        prefixIcon: Icon(Icons.search)),
                    onChanged: (t) {},
                  )),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  controller.getRealTimeWeather();
                },
              ),
            ],
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: WeatherLeftPage()),
            Expanded(flex: 5, child: WeatherDetailView()),
          ],
        ),
      );
    });

  }
}
