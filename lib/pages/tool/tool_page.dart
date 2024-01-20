import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skuu_web/bean/tool_item_bean.dart';
import 'package:skuu_web/component/tool_item.dart';
import 'package:skuu_web/pages/tool/date_tool_page.dart';
import 'package:skuu_web/route/routers.dart';

import '../../constant/color_constant.dart';

class ToolPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ToolPage();
  }
}

class _ToolPage extends State<ToolPage> {
  List<String> showItems = [];
  List<String> allItems = [];
  List<Widget> allPages = [];
  List<ToolItemBean> showToolItemBeans = [];
  List<ToolItemBean> allToolItemBeans = [];

  int colCount = 2;

  @override
  void initState() {
    super.initState();
    allItems.addAll([
      '时间工具',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
      '1',
    ]);
    allPages.addAll([
      DateToolPage(),
    ]);

    allToolItemBeans.add(ToolItemBean(
        imageUrl: "imgs/date.svg",
        title: "时间转换",
        subTitle: "文本工具",
        desc: "时间和时间戳的互相转换",
        indexLetter: "shijian",
        clickUrl: Routes.dateToolPageUrl));
    allToolItemBeans.add(ToolItemBean(
        imageUrl: "imgs/URL_args.svg",
        title: "URL编码/解码",
        subTitle: "文本工具",
        desc: "URL编码/解码互相转换",
        indexLetter: "url",
        clickUrl: Routes.urlToolPageUrl));
    allToolItemBeans.add(ToolItemBean(
        imageUrl: "imgs/ip.svg",
        title: "IP查询",
        subTitle: "地址工具",
        desc: "IP查询，定位",
        indexLetter: "ip",
        clickUrl: Routes.urlToolPageUrl));
    allToolItemBeans.add(ToolItemBean(
        imageUrl: "imgs/phone.svg",
        title: "手机号查询",
        subTitle: "地址工具",
        desc: "手机号查询，定位",
        indexLetter: "phone",
        clickUrl: Routes.urlToolPageUrl));
    showToolItemBeans = allToolItemBeans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorConstant.lightBlue,
            title: Container(
                width: 0.8.sw,
                height: 40,
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.w),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "快速搜索",
                      prefixIcon: Icon(Icons.search)),
                  onChanged: (t) {
                    if (t.isNotEmpty) {
                      setState(() {
                        showToolItemBeans = filter(allToolItemBeans, t);
                      });
                    } else {
                      setState(() {
                        showToolItemBeans = allToolItemBeans;
                      });
                    }
                  },
                ))),
        backgroundColor: Colors.black12,
        // backgroundColor: ColorConstant.lightBlue,
        body: MasonryGridView.count(
          crossAxisCount: getColCount(),
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          itemCount: showToolItemBeans.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              child: ToolItem(showToolItemBeans[index]),
              onHover: (a) {},
              onTap: () {
                Routes.navigateTo(context, showToolItemBeans[index].clickUrl);
              },
            );
          },
        ));
  }

  int getColCount() {
    double len = MediaQuery.of(context).size.width;
    int count = (len / 300).truncate();
    return count;
  }

  List<ToolItemBean> filter(List<ToolItemBean> items, String name) {
    List<ToolItemBean> fil = [];
    for (var value in items) {
      if (value.indexLetter.contains(name)) {
        fil.add(value);
      }
    }
    return fil;
  }
}
