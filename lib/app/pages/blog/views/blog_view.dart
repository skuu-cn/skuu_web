import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:skuu/app/pages/blog/controllers/blog_controller.dart';
import 'package:skuu/app/pages/blog/domain/entity/blog_page_model.dart';
import 'package:skuu/app/pages/blog/views/blog_img_item_view.dart';
import 'package:skuu/app/pages/blog/views/blog_video_item_view.dart';

import '../../index/controllers/index_controller.dart';

class BlogView extends GetView<BlogController> {
  BlogView({super.key});

  final indexController = Get.find<IndexController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.black12,
        body: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: MasonryGridView.count(
              itemCount: controller.blogItems.length,
              crossAxisCount: controller.colCount,
              controller: controller.scrollController,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              itemBuilder: (context, index) {
                BlogItem blogItem = controller.blogItems[index];
                if (blogItem.blogType == 1) {
                  return Material(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      height: controller.getImgItemHeight(
                          blogItem.resources!.split(",").length > 6
                              ? 6
                              : blogItem.resources!.split(",").length,
                          index * 100),
                      child: BlogImgItemView(
                        blogItem: blogItem,
                        onAvatarTap: () => controller.onUserAvatarTap(blogItem),
                        onCardTap: () => controller.onBlogItemTap(blogItem),
                        onCareTap: () => controller.onCareTap(blogItem),
                        onZanTap: () => controller.onZanTap(blogItem),
                      ),
                    ),
                  );
                } else {
                  return Material(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      height: controller.getVideoItemHeight(),
                      child: BlogVideoItemView(
                        blogItem: blogItem,
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
