import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/blog/controllers/blog_controller.dart';
import 'package:skuu/app/pages/blog/domain/entity/blog_page_model.dart';
import 'package:skuu/app/pages/blog/views/blog_img_item_view.dart';
import 'package:skuu/app/pages/blog/views/blog_video_item_view.dart';
import 'package:skuu/app/pages/index/controllers/home_controller.dart';

import '../../index/controllers/index_controller.dart';

class BlogView extends GetView<BlogController> {
  BlogView(this.categary, {super.key});

  final int categary;
  final indexController = Get.find<IndexController>();
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    homeController.setColCount(1.sw);
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: MasonryGridView.count(
              itemCount: controller.blogItems.length,
              crossAxisCount: homeController.colCount.value,
              controller: indexController.controllers[0],
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              itemBuilder: (context, index) {
                BlogItem blogItem = controller.blogItems[index];
                if (blogItem.blogType == 1) {
                  return Card(
                    child: BlogImgItemView(
                      blogItem: blogItem,
                      categary: categary,
                      onAvatarTap: () => controller.onUserAvatarTap(blogItem),
                      onCardTap: () => controller.onBlogItemTap(blogItem),
                      onCareTap: () => controller.onCareTap(blogItem),
                      onZanTap: () => controller.onZanTap(blogItem),
                    ),
                  );
                } else {
                  return Material(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      height: controller
                          .getVideoItemHeight(homeController.colCount.value),
                      child: BlogVideoItemView(
                        blogItem: blogItem,
                        categary: categary,
                        onCardTap: () => controller.onBlogItemTap(blogItem),
                        onCareTap: () => controller.onCareTap(blogItem),
                        onZanTap: () => controller.onZanTap(blogItem),
                      ),
                    ),
                  );
                }
              },
            )),
      );
    });
  }
}
