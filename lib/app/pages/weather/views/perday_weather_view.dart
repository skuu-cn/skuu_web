import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/weather/controllers/weather_controller.dart';

import '../../../components/custom_process_widget.dart';

class PerDayWeatherView extends GetView<WeatherController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(builder: (a) {
      return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Container(
                  width: 450,
                  height: 160,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Card(
                          color: Colors.grey,
                          child: Container(
                            width: 450,
                            height: 160,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '北京朝阳',
                            style: TextStyle(
                                fontSize: 20,
                                color: controller.ifOnHour
                                    ? Colors.red
                                    : Colors.white),
                          ),
                          Text(
                            '温度：32 ℃   |  体感温度：33 ℃',
                            style: TextStyle(
                                fontSize: 20,
                                color: controller.ifOnHour
                                    ? Colors.red
                                    : Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'imgs/weather/100.svg',
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                                colorFilter: ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn),
                              ),
                              Text(
                                '多云',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: controller.ifOnHour
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 20,
                            children: [
                              Text(
                                '观察时间 \n 12:00:00',
                                style: TextStyle(
                                    color: controller.ifOnHour
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                '西风 \n 3级',
                                style: TextStyle(
                                    color: controller.ifOnHour
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                '湿度 \n 30%',
                                style: TextStyle(
                                    color: controller.ifOnHour
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                '能见度 \n 21公里',
                                style: TextStyle(
                                    color: controller.ifOnHour
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                '过去1小时降水量 \n 3毫米',
                                style: TextStyle(
                                    color: controller.ifOnHour
                                        ? Colors.red
                                        : Colors.white),
                              ),
                              Text(
                                '大气压强 \n 1221Hpa',
                                style: TextStyle(
                                    color: controller.ifOnHour
                                        ? Colors.red
                                        : Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  height: 160,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Card(
                          color: Colors.grey,
                          child: Container(
                            width: 450,
                            height: 160,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '24小时天气',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              Divider(),
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (int i = 0; i <= 23; i++)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: Column(
                                          spacing: 10,
                                          children: [
                                            Text(
                                              '现在',
                                              style: TextStyle(
                                                  color: controller.ifOnHour
                                                      ? Colors.red
                                                      : Colors.white),
                                            ),
                                            SvgPicture.asset(
                                              'imgs/weather/100.svg',
                                              fit: BoxFit.cover,
                                              height: 35,
                                              width: 35,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn),
                                            ),
                                            Text(
                                              '28℃',
                                              style: TextStyle(
                                                  color: controller.ifOnHour
                                                      ? Colors.red
                                                      : Colors.white),
                                            ),
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  height: 480,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Card(
                          color: Colors.grey,
                          child: Container(
                            width: 450,
                            height: 480,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            spacing: 10,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '最近10天天气',
                                    style: TextStyle(
                                        color: controller.ifOnHour
                                            ? Colors.red
                                            : Colors.white),
                                  ),
                                ],
                              ),
                              Divider(),
                              for (int i = 0; i < 10; i++)
                                Row(
                                  spacing: 10,
                                  children: [
                                    Text(
                                      '今天',
                                      style: TextStyle(
                                          color: controller.ifOnHour
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 50, right: 50),
                                      child: SvgPicture.asset(
                                        'imgs/weather/100.svg',
                                        fit: BoxFit.cover,
                                        height: 30,
                                        width: 30,
                                        colorFilter: ColorFilter.mode(
                                            Colors.white, BlendMode.srcIn),
                                      ),
                                    ),
                                    Text(
                                      '18℃',
                                      style: TextStyle(
                                          color: controller.ifOnHour
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                    Expanded(
                                        child:
                                            CustomeProcess(14, 32, 14, 27, 5)),
                                    Text(
                                      '28℃',
                                      style: TextStyle(
                                          color: controller.ifOnHour
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                  ],
                                )
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  width: 450,
                  height: 480,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: Card(
                          color: Colors.grey,
                          child: Container(
                            width: 450,
                            height: 480,
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '生活指数',
                                    style: TextStyle(
                                        color: controller.ifOnHour
                                            ? Colors.red
                                            : Colors.white),
                                  ),
                                ],
                              ),
                              Divider(),
                              Expanded(
                                  child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  // crossAxisSpacing: 3,
                                  childAspectRatio: 3,
                                ),
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Icon(
                                      Icons.ac_unit_outlined,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      '舒适度指数',
                                      style: TextStyle(
                                          color: controller.ifOnHour
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                    subtitle: Text(
                                      '较舒适',
                                      style: TextStyle(
                                          color: controller.ifOnHour
                                              ? Colors.red
                                              : Colors.white),
                                    ),
                                  );
                                },
                              )),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
