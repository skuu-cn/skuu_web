import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:skuu/app/pages/blog/domain/entity/blog_page_model.dart';

import '../../../../constant/color_constant.dart';
import '../../../../constant/constant.dart';
import '../../../components/level_icon.dart';
import '../../../components/myshare_page.dart';

class BlogImgItemView extends StatelessWidget {
  final BlogItem blogItem;

  //头像
  final VoidCallback? onAvatarTap;

  //点击卡片
  final VoidCallback? onCardTap;

  //赞
  final VoidCallback? onZanTap;

  //关注
  final VoidCallback? onCareTap;

  const BlogImgItemView(
      {super.key,
      required this.blogItem,
      this.onAvatarTap,
      this.onCardTap,
      this.onZanTap,
      this.onCareTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
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
          Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: SelectableText(
              blogItem.content!,
              scrollPhysics: NeverScrollableScrollPhysics(),
              maxLines: 3,
              minLines: 1,
              style: TextStyle(
                fontSize: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          if (blogItem.resources!.split(",").length > 0)
            Expanded(
              // flex: 9,
              child: InkWell(
                onTap: onCardTap,
                child: Container(
                  child: GridView.builder(
                      padding: EdgeInsets.only(top: 2.0),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              getCount(blogItem.resources!.split(",").length),
                          childAspectRatio: 1,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0),
                      itemCount: blogItem.resources!.split(",").length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          blogItem.resources!.split(",")[index],
                          fit: BoxFit.fill,
                        );
                      }),
                ),
              ),
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
                tooltip: "更多",
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

  int getCount(int count) {
    if (count <= 3) {
      return count;
    } else {
      return 3;
    }
  }
}
