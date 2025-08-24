import 'package:get/get.dart';
import 'package:skuu/app/pages/index/controllers/home_controller.dart';
import 'package:skuu/app/pages/weather/controllers/weather_controller.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeatherController(),fenix: true);
  }
}
