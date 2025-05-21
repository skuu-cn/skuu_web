import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/weather/controllers/weather_controller.dart';

import '../../../constant/constant.dart';
import '../../data/models/city_model_entity.dart';
import '../../routes/app_pages.dart';

class WeatherLeftPage extends GetView<WeatherController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(builder: (_) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              if (1.sw <= Constant.CHAT_TWO_VIEW_WIDTH) {
                Get.toNamed(Routes.weatherRightPageUrl);
                controller.changeIndexLeft1(index);
              } else {
                controller.changeIndexLeft(index);
              }
            },
            child: ListItemWidget(
              weatherType: controller.realTimeWeathers[index].now.weatherType,
              city: controller.citys[index],
              weatherText: controller.realTimeWeathers[index].now.text,
              selected: controller.currentPage == index,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5,
          );
        },
        itemCount: controller.realTimeWeathers.length,
      );
    });
  }
}

class ListItemWidget extends StatelessWidget {
  final WeatherType weatherType;
  final CityModelLocation city;
  final String weatherText;
  final bool selected;

  ListItemWidget(
      {Key? key,
      required this.weatherType,
      required this.city,
      required this.weatherText,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ClipPath(
        child: Stack(
          children: [
            WeatherBg(
              weatherType: weatherType,
              width: MediaQuery.of(context).size.width,
              height: 100,
            ),
            Container(
              alignment: Alignment(-0.8, 0),
              height: 100,
              child: Text(
                selected
                    ? '👉 ${city.adm2}-${city.name}'
                    : '${city.adm2}-${city.name}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment(0.8, 0),
              height: 100,
              child: Text(
                weatherText,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
