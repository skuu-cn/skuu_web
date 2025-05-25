import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:geolocator_web/geolocator_web.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skuu/app/pages/weather/views/perday_weather_view.dart';
import 'package:skuu/app/services/base_client.dart';
import 'package:skuu/constant/api_constant2.dart';

import '../../../components/AnimatedBottomBar.dart';
import '../../../data/models/city_model_entity.dart';
import '../../../data/models/real_time_weather_entity.dart';
import '../views/perhour_weather_view.dart';

class WeatherController extends GetxController {
  var locationState;
  int currentPage = 0;

  static const String _locationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _permissionDeniedMessage = 'Permission denied.';
  static const String _permissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _permissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  late Position curPosition;
  late CityModelEntity curCity;

  StreamSubscription<Position>? _positionStreamSubscription;
  late RealTimeWeatherEntity realTimeWeather;
  var citys = <CityModelLocation>[];
  var realTimeWeathers = <RealTimeWeatherEntity>[];
  var weatherMaps = <Map>[];
  bool ifOnHour = false;

  final List<BarItem> barItems = [
    BarItem(
      text: "实时天气",
      selectPath: "imgs/index-selv2.svg",
      unSelectPath: "imgs/index.svg",
      color: Colors.white,
    ),
    BarItem(
      text: "24小时预报",
      selectPath: "imgs/video-sel.svg",
      unSelectPath: "imgs/video.svg",
      color: Colors.white,
    ),
    BarItem(
      text: "7天预报",
      selectPath: "imgs/msg-selv2.svg",
      unSelectPath: "imgs/msg.svg",
      color: Colors.white,
    ),
    BarItem(
      text: "天气指数",
      selectPath: "imgs/me-selv2.svg",
      unSelectPath: "imgs/me.svg",
      color: Colors.white,
    ),
  ];
  List<Widget> mainView = [
    PerDayWeatherView(),
    PerHourWeatherView(),
  ];

  @override
  void onInit() {
    toggleListening();
    getRealTimeWeather();

    // getCurCity(curPosition.latitude, curPosition.longitude);
    // CityModelLocation cityModelLocation =  curCity.location.first;
    // citys.addAll(['当前：${cityModelLocation.name}', "朝阳", "海淀", "郓城"]);
    // print(citys);
    super.onInit();
  }

  void changeHour() {
    ifOnHour = !ifOnHour;
    update();
  }

  void changeIndexRight(int n) {
    currentPage = n;
    update();
  }

  String getWeatherKey(int index, int index1) {
    return weatherMaps[index].keys.toList()[index1];
  }

  String getWeatherVlaue(int index, int index1) {
    String key = getWeatherKey(index, index1);
    return weatherMaps[index][key];
  }

  void changeIndexLeft1(int n) {
    currentPage = n;
    update();
  }

  void changeIndexLeft(int n) {
    if (currentPage == n) {
      return;
    }
    currentPage = n;
    update();
  }

  Future<void> loadAddressData() async {
    try {
      await rootBundle.loadString('mock/weather_city.json').then((value) {
        final Map<String, dynamic> jsonData = jsonDecode(value);
        citys = CityModelEntity.fromJson(jsonData).location;
      });
      update();
    } catch (e) {
      print('Error loading mock city data: $e');
    }
  }

  void toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => _updatePositionList(
            position,
          ));
      _positionStreamSubscription?.pause();
    }

    if (_positionStreamSubscription == null) {
      return;
    }
    if (_positionStreamSubscription!.isPaused) {
      _positionStreamSubscription!.resume();
    } else {
      _positionStreamSubscription!.pause();
    }
    update();
  }

  void _updatePositionList(Position posi) {
    curPosition = posi;
    print('Listening1 for position updates $posi');
  }

  Future<void> _updateRealTimeWeather(double lat, double lon) async {
    String latStr = lat.toStringAsFixed(2);
    String lonStr = lon.toStringAsFixed(2);
    String location = '?location=$lonStr,$latStr';
    String url = ApiConstant2.HE_FENG_BASE_API +
        ApiConstant2.REALTIME_WEATHER +
        location;
    Map<String, dynamic> header = {};
    header.assign('X-QW-Api-Key', ApiConstant2.API_KEY);
    await BaseClient.safeApiCall(url, RequestType.get, headers: header,
        onSuccess: (res) {
      RealTimeWeatherEntity realTimeWeatherEntity =
          RealTimeWeatherEntity.fromJson(res.data);
      realTimeWeatherEntity.now.weatherType =
          transWeatherType(realTimeWeatherEntity);
      realTimeWeathers.add(realTimeWeatherEntity);
      setWeatherMap(realTimeWeatherEntity.now);
    });
  }

  Future<void> _updateRealTimeWeatherMock(double lat, double lon) async {
    await rootBundle.loadString('mock/realtime_weather.json').then((value) {
      final Map<String, dynamic> jsonData = jsonDecode(value);
      RealTimeWeatherEntity realTimeWeatherEntity =
      RealTimeWeatherEntity.fromJson(jsonData);
      realTimeWeatherEntity.now.weatherType =
          transWeatherType(realTimeWeatherEntity);
      realTimeWeathers.add(realTimeWeatherEntity);
      setWeatherMap(realTimeWeatherEntity.now);
    });
  }

  void setWeatherMap(RealTimeWeatherNow now) {
    var format2 = DateFormat('HH:mm:ss');
    DateTime dateTime = DateTime.parse(now.obsTime);
    Map<String, String> map = {};
    map["观察时间"] = format2.format(dateTime.toLocal());
    map["温度"] = now.temp + '°C';
    map["体感温度"] = now.feelsLike + '°C';
    map[now.windDir] = now.windScale + "级";
    map["相对湿度"] = now.humidity + '%';
    map["能见度"] = now.vis + '公里';
    map["过去1小时降水量"] = now.precip + '毫米';
    map["大气压强"] = now.pressure + 'hPa';
    weatherMaps.add(map);
    update();
  }

  WeatherType transWeatherType(RealTimeWeatherEntity realTimeWeatherEntity) {
    String text = realTimeWeatherEntity.now.text;
    if (text.contains('云')) {
      return WeatherType.cloudy;
    } else if (text.contains('雨')) {
      return WeatherType.heavyRainy;
    } else if (text.contains('雪')) {
      return WeatherType.heavySnow;
    } else if (text.contains('雷')) {
      return WeatherType.thunder;
    } else if (text.contains('霾')) {
      return WeatherType.hazy;
    } else if (text.contains('雾')) {
      return WeatherType.foggy;
    } else {
      return WeatherType.sunny;
    }
  }

  Future<void> getCurCity(double lat, double lon) async {
    String latStr = lat.toStringAsFixed(2);
    String lonStr = lon.toStringAsFixed(2);
    String location = '?location=$lonStr,$latStr';
    String url =
        ApiConstant2.HE_FENG_BASE_API + ApiConstant2.HE_CITY_API + location;
    print('City URL: $url'); // Debug URL
    Map<String, dynamic> header = {'X-QW-Api-Key': ApiConstant2.API_KEY};

    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      headers: header,
      onSuccess: (res) {
        curCity = CityModelEntity.fromJson(res.data);
        print('Current city: ${curCity}');
      },
      onError: (e) {
        print('City API error: $e');
      },
    );
  }

  Future<void> getRealTimeWeather() async {
    final bool hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }
    final Position position = await _geolocatorPlatform.getCurrentPosition();
    curPosition = position;
    // await getCurCity(curPosition.latitude, curPosition.longitude);
    // print("getCurCity end");
    // CityModelLocation cityModelLocation = curCity.location.first;
    // citys.addAll(['当前：${cityModelLocation.name}', "朝阳", "海淀", "郓城"]);
    await loadAddressData();
    // await _updateRealTimeWeather(position.latitude, position.longitude);
    for (CityModelLocation city in citys) {
      await _updateRealTimeWeatherMock(
          double.parse(city.lat), double.parse(city.lon));
    }

    print('realTimeWeathers,$realTimeWeathers');
    update();
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return true;
  }

  @override
  void onClose() {
    _positionStreamSubscription?.cancel();
    super.onClose();
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
