import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/demo/getx/controllers/demo_controller.dart';

class DemoPage extends GetView<DemoController> {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DemoController>(builder: (a) {
      return Scaffold();
    });
  }
}
