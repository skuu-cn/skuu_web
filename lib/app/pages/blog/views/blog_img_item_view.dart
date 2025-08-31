import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skuu/app/pages/blog/controllers/blog_controller.dart';
import 'package:skuu/app/pages/blog/domain/entity/blog_page_model.dart';

import '../../../../constant/color_constant.dart';
import '../../../../constant/constant.dart';
import '../../../components/level_icon.dart';
import '../../../components/myshare_page.dart';
import '../../index/controllers/home_controller.dart';

class BlogImgItemView extends StatelessWidget {
  final BlogItem blogItem;
  final int categary;

  //头像
  final VoidCallback? onAvatarTap;

  //点击卡片
  final VoidCallback? onCardTap;

  //赞
  final VoidCallback? onZanTap;

  //关注
  final VoidCallback? onCareTap;

  //预览图片
  final blogController = Get.find<BlogController>();

  BlogImgItemView(
      {super.key,
      required this.blogItem,
      this.onAvatarTap,
      this.onCardTap,
      this.onZanTap,
      this.onCareTap,
      required this.categary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'imgs/img_default.png',
                  width: Constant.HEAD_IMG_SEZE,
                  height: Constant.HEAD_IMG_SEZE,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: AutoSizeText(
                          '${blogItem.creatorName}',
                          style: const TextStyle(fontSize: 20),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ),
                      LevelIcon(lv: Random().nextInt(7)),
                    ],
                  ),
                  Container(
                    height: 2,
                    color: Colors.white,
                  ),
                  const Text(
                    '关注 32 KW ◉️ 活跃 333 KW',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: blogItem.care == 1
                      ? ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 35),
                          padding: EdgeInsets.only(left: 10, right: 10),
                        )
                      : ElevatedButton.styleFrom(
                          minimumSize: const Size(20, 35),
                          padding: EdgeInsets.only(left: 13, right: 13),
                          backgroundColor: ColorConstant.ThemeGreen,
                        ),
                  child: blogItem.care == 1
                      ? Text(
                          "已关注",
                          style: const TextStyle(
                              fontSize: 13, color: ColorConstant.ThemeGreen),
                        )
                      : Text(
                          "关注",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.white),
                        ),
                  onPressed: onCareTap,
                ),
              )
            ],
          ),
          SelectableText(
            blogItem.content!,
            scrollPhysics: NeverScrollableScrollPhysics(),
            maxLines: 3,
            minLines: 1,
            style: TextStyle(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double parentWidth = constraints.maxWidth;
              return Wrap(
                children: [
                  for (int i = 0;
                      i < blogItem.resources!.split(",").length;
                      i++)
                    Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 10),
                      child: InkWell(
                        child: Hero(
                          child: SizedBox(
                            height: getImgGridHeight(
                                blogItem.resources!.split(",").length,
                                parentWidth),
                            child: Image.network(
                              blogItem.resources!.split(",")[i],
                            ),
                          ),
                          tag: 'lookBlogImg-${categary}-${blogItem.id}-$i',
                        ),
                        onTap: () {
                          blogController.onBlogImgItemTap(blogItem, i,
                              'lookBlogImg-${categary}-${blogItem.id}-$i');
                        },
                      ),
                    )
                ],
              );
            },
          ),
          Row(
            children: <Widget>[
              TextButton.icon(
                onPressed: onZanTap,
                icon: blogItem.zan == 1
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                      ),
                label: Text(
                  blogItem.zan == 1 ? '取消' : '喜欢',
                ),
              ),
              TextButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent)),
                onPressed: onCardTap,
                icon: Icon(
                  Icons.comment,
                ),
                label: Text(
                  '评论',
                ),
              ),
              MySharePage(),
              Spacer(),
              PopupMenuButton(
                tooltip: '',
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.black54,
                ),
                onSelected: (va) {
                  print(va);
                },
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: '0',
                      child: Text(
                        '收藏',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: '1',
                      child: Text(
                        '举报',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: '2',
                      child: Text(
                        '不感兴趣',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  double getImgGridHeight(int itemCount, double parentWidth) {
    if (itemCount == 1) {
      return 300;
    } else if (itemCount == 3 || itemCount == 5 || itemCount == 6) {
      return (parentWidth - 30) / 3;
    } else {
      return parentWidth / 3;
    }
  }
}

int getCount(int count) {
  if (count <= 3) {
    return count;
  } else {
    return 3;
  }
}
