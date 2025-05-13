import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skuu/app/pages/fabu/views/fabu_aixin_page.dart';
import 'package:skuu/app/pages/fabu/views/fabu_goods_page.dart';

import '../../../../constant/color_constant.dart';
import 'fabu_dynamic_page.dart';
import 'fabu_video_page.dart';

class FabuZuoPinPage extends StatefulWidget {
  const FabuZuoPinPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FabuZuoPinPage();
  }
}

class _FabuZuoPinPage extends State<FabuZuoPinPage>
    with SingleTickerProviderStateMixin {
  //tab控制
  late TabController tabController;
  late List<String> tabTitle = [
    '发布动态',
    '发布视频',
    '发布商品',
    '发布爱心',
  ];
  late List<Widget> tabBoby = [
    FabuDynamicPage(),
    FabuVideoPage(),
    FabuGoodsPage(),
    FabuAiXinPage(),
  ];


  @override
  void initState() {
    tabController = TabController(
      length: tabTitle.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: TabBar(
                controller: tabController,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: tabTitle.length > 2 ? true : false,
                tabs: tabTitle.map((e) {
                  return Container(
                    height: 120.h,
                    width: 100.w,
                    alignment: Alignment.center,
                    child: Text(e),
                  );
                }).toList()),
            actions: [
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  '发布',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.ThemeGreen,
                ),
              ),
              SizedBox(
                width: 5,
              )
            ]),
        body: TabBarView(
          controller: tabController,
          // physics:const NeverScrollableScrollPhysics(),
          children: tabBoby,
        ));
  }
}
