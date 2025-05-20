import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/print_utils.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/weather/controllers/weather_controller.dart';

/// 普通的 ViewPager 展示样式
class WeatherDetailView extends GetView<WeatherController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(builder: (a) {
      return Container(
        child: PageView.builder(
          controller: controller.pageController,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                WeatherBg(
                  weatherType:
                      controller.realTimeWeathers[index].now.weatherType,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Center(
                  child: Text(
                    controller.realTimeWeathers[index].now.text,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            );
          },
          itemCount: controller.realTimeWeathers.length,
          onPageChanged: (int index) {
            controller.changeIndexRight(index);
          },
        ),
      );
    });
  }
}
