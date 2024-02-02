import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skuu_web/pages/goods/goods_item.dart';

import '../me/mywork_item2.dart';

//商品列表页
class GoodsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoodsPage();
  }
}

class _GoodsPage extends State<GoodsPage> {
  final List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _items.addAll([
      '1',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("商品列表"),),
      backgroundColor: Colors.black12,
      body: Padding(
        padding: EdgeInsets.all(1),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 431.0,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio:3/2),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return GoodsItem();
            }),
      ),
    );
  }
}
