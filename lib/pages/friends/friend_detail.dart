import 'package:flutter/material.dart';

class FriendDetail extends StatelessWidget {
  final String title;

  FriendDetail({required this.title});

  @override
  Widget build(BuildContext context) {
    return getContent();
  }

  Widget getContent() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    // Row(
                    //   children: <Widget>[
                    //     Text(
                    //       title,
                    //       textAlign: TextAlign.left,
                    //       style: TextStyle(color: Colors.black, fontSize: 30),
                    //     ),
                    //     Image.asset(
                    //       'imgs/img_default.png',
                    //       width: 30,
                    //       height: 30,
                    //     ),
                    //   ],
                    // ),
                    Text(
                      '新人类文明',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.grey, fontSize: 21),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              color: Colors.grey,
              margin: EdgeInsets.only(top: 10),
              height: 1,
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  Text(
                    '备注',
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    '哒哒哒哒',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '地区',
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    '北京-海淀',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'skuu号',
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    'sk-001',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '来源',
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    '手机号添加',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                  ),
                ]),
              ],
            ),
            Container(
              color: Colors.grey,
              margin: EdgeInsets.only(top: 10),
              height: 1,
            ),
            Container(height: 10,),
            ElevatedButton(
              child: Text(
                '发消息',
                style: TextStyle(color: Colors.lightBlue),
              ),
              onPressed: () => {},
            ),
          ],
        ));
  }
}
