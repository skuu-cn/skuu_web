import 'package:get/get.dart';

import '../thumbnail_page.dart';


class ToolController extends GetxController {

  Map<int, GenThumbnailImage> imgMap = {};

  void setGenThumbnailImage(int index, GenThumbnailImage gen) {
    imgMap[index] = gen;
    update();
  }
}
