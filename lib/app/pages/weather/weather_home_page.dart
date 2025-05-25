import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/weather/controllers/weather_controller.dart';
import 'package:skuu/app/pages/weather/weather_detail_view.dart';
import 'package:skuu/app/pages/weather/weather_left_page.dart';
import 'package:skuu/constant/constant.dart';

class WeatherHomePage extends GetView<WeatherController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Spacer(),
              Container(
                  width: 0.7.sw,
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
                    onTap: () async {
                      // type 2
                      Result? result2 = await CityPickers.showFullPageCityPicker(
                        showType: ShowType.pcav,
                        context: context,
                      );
                      print(result2);
                    },
                    // onChanged: (t) async {
                    //
                    // },
                  )),
              IconButton(
                icon: Icon(Icons.location_on),
                onPressed: () {
                  controller.getRealTimeWeather();
                },
              ),
              Spacer(),
            ],
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 2, child: WeatherLeftPage()),
            if (1.sw > Constant.CHAT_TWO_VIEW_WIDTH)
              Expanded(flex: 5, child: WeatherDetailView()),
          ],
        ),
      );
    });
  }
}
