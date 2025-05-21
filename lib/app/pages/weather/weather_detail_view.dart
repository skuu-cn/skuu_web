import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/print_utils.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/weather/controllers/weather_controller.dart';
import 'package:skuu/constant/constant.dart';

/// 普通的 ViewPager 展示样式
class WeatherDetailView extends GetView<WeatherController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(builder: (a) {
      return Scaffold(
        appBar: 1.sw > Constant.CHAT_TWO_VIEW_WIDTH
            ? null
            : AppBar(
                title: Text(controller.citys
                        .elementAt(controller.currentPage)
                        .adm2 +'-'+
                    controller.citys.elementAt(controller.currentPage).name),
              ),
        body: Container(
          child: PageView.builder(
            controller: controller.pageController,
            scrollDirection: Axis.vertical,
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
                      child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, // 每个子项的最大宽度
                      crossAxisSpacing: 8, // 列间距
                      mainAxisSpacing: 8, // 行间距
                      childAspectRatio: 1, // 子项宽高比（1 表示正方形） //显示区域宽高相等
                    ),
                    itemCount: controller.weatherMaps[index].length,
                    itemBuilder: (BuildContext context, int index1) {
                      return Center(
                        child: InkWell(
                          onTap: () {
                            controller.changeHour();
                          },
                          child: Text(
                            controller.getWeatherKey(index, index1) +
                                '\n' +
                                controller.getWeatherVlaue(index, index1),
                            style: TextStyle(
                                color: controller.ifOnHour
                                    ? Colors.red
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              );
            },
            itemCount: controller.realTimeWeathers.length,
            onPageChanged: (int index) {
              controller.changeIndexRight(index);
            },
          ),
        ),
      );
    });
  }
}
