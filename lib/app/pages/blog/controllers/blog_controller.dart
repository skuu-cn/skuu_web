import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/blog/domain/adapters/iblog_page_repo.dart';
import 'package:skuu/app/pages/blog/domain/entity/blog_page_model.dart';
import 'package:skuu/app/routes/app_pages.dart';

class BlogController extends GetxController {

  final blogPageModel = BlogPageModel().obs;
  final RxnNum total = RxnNum(0);
  final RxList<BlogItem> blogItems = <BlogItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final IBlogPageRepo blogPageRepo;

  BlogController({required this.blogPageRepo});

  late int colCount = 2;
  late double scrollOffset = 0;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    loadBlogPageModel();
    super.onReady();
  }

  Future<void> loadBlogPageModel() async {
    try {
      isLoading.value = true;
      BlogPageModel res = await blogPageRepo.getBlogPageModel(1);
      blogPageModel.value = res;
      total.value = res.data!.total!;
      blogItems.value = res.data!.list!;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // 跳转到博客详情页
  void onBlogItemTap(BlogItem blogItem) {
    if (blogItem.blogType == 1) {
      Get.toNamed(Routes.whatArticle, arguments: blogItem);
    } else {
      Get.toNamed(Routes.watchVideo, arguments: blogItem);
    }
  }

  //点击头像事件
  void onUserAvatarTap(BlogItem blogItem) {
    Get.toNamed(Routes.whatArticle, arguments: blogItem);
  }

  //关注
  void onCareTap(BlogItem blogItem) {}

  //点赞
  void onZanTap(BlogItem blogItem) {}

  void setColCount(double len) {
    if (len < 1000) {
      colCount = 1;
    } else {
      colCount = 2;
    }
  }

  void setScrollOffset(double curScrollOffset) {
    scrollOffset = curScrollOffset;
  }

  //动态根据图片个数算item高度
  double getImgItemHeight(int itemCount, double length) {
    length = length == 0 ? 100 : length;
    double widthItem = 1.sw;
    if (colCount > 1) {
      widthItem = 0.5.sw;
    }
    length =
        '长风破浪会有时，直挂云帆济沧海。长风破浪会有时，直挂云帆济沧海。长风破浪会有时，直挂云帆济沧海。'.length.toDouble();
    length = length * 22;
    double lineCount = (length / widthItem).ceilToDouble();
    double wordHeight = (lineCount > 3 ? 3 : lineCount) * 30 + 102;
    //没有图片的时候
    if (itemCount == 0) {
      return wordHeight;
    }
    //图片超过3个的时候，高度固定
    if (itemCount > 3) {
      return (2 / 3) * widthItem + wordHeight;
    }
    return widthItem / itemCount + wordHeight;
  }

  double getVideoItemHeight() {
    double widthItem = 1.sw;
    if (colCount > 1) {
      widthItem = 0.5.sw;
    }
    return widthItem / (15 / 9) + 150;
  }

  int getImgItemCount() {
    return Random().nextInt(3) + 1;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
