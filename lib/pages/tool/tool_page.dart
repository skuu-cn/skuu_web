import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skuu_web/pages/tool/date_tool_page.dart';
import 'package:skuu_web/route/routers.dart';

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

  int colCount = 2;

  @override
  void initState() {
    super.initState();
    allItems.addAll([
      '时间（date）',
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
    showItems = allItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white38,
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
                        showItems = filter(allItems, t);
                      });
                    } else {
                      setState(() {
                        showItems = allItems;
                      });
                    }
                  },
                ))),
        backgroundColor: Colors.black12,
        body: MasonryGridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          itemCount: showItems.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent),
              child: Text(showItems[index]),
              onPressed: () {
                Routes.navigateTo(context, Routes.dateToolPageUrl);
              },
            );
          },
        ));
  }

  int getColCount(double len) {
    if (len < 1000) {
      return 2;
    } else if (len >= 1000 && len < 1500) {
      return 4;
    } else {
      return 6;
    }
  }

  List<String> filter(List<String> items, String name) {
    List<String> fil = [];
    for (var value in items) {
      if (value.contains(name)) {
        fil.add(value);
      }
    }
    return fil;
  }
}
