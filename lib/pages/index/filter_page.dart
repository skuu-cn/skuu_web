import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/color_constant.dart';

class FilterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterPage();
  }
}

class _FilterPage extends State<FilterPage> {
  List<String> commonNames = [];
  List<String> commonNamesSel = [];

  @override
  void initState() {
    super.initState();
    commonNames.addAll([
      '热榜',
      '小说',
      '娱乐',
      '科技',
      '军事',
      '国际',
      '漫画',
      '游戏',
      '影视',
      '搞笑',
      '故事',
      '法律',
      '车辆',
      '健康',
      '三农',
      '情感',
      '家居',
      '星座',
      '养生',
      '育儿',
      '股票',
      '彩票',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(
              child: Text(
                '标签筛选',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 10,
            ),
            Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.start, //沿主轴方向居中
              children: <Widget>[
                for (var value in commonNames)
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.lightBlue),
                      onPressed: () {
                        setState(() {
                          if (commonNamesSel.contains(value)) {
                            commonNamesSel.remove(value);
                          } else {
                            commonNamesSel.add(value);
                          }
                        });
                      },
                      icon: commonNamesSel.contains(value)
                          ? Icon(Icons.offline_pin)
                          : Icon(
                              Icons.add_circle,
                              color: Colors.green,
                            ),
                      label: Text(value))
              ],
            ),
            Spacer(),
            Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            commonNamesSel.clear();
                          });
                        },
                        child: Container(
                          child: Center(
                            child: Text(
                              '重置',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20))),
                          // color: Colors.red,
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Center(
                            child: Text(
                              '完成',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          // color: Colors.red,
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
