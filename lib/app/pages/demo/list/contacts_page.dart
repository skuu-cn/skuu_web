import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lpinyin/lpinyin.dart';

import '../../../../util/utils.dart';
import '../../../components/azlist/az_common.dart';
import '../../../components/azlist/az_listview.dart';
import '../../../components/azlist/index_bar.dart';
import '../../../data/models/contact.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material",
      home: ContactsPage(),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<ContactInfo> contactList = [];
  List<ContactInfo> topList = [];

  @override
  void initState() {
    super.initState();
    topList.add(ContactInfo(
        name: '新的朋友',
        tagIndex: '↑',
        bgColor: Colors.orange,
        iconData: Icons.person_add));
    topList.add(ContactInfo(
        name: '群聊',
        tagIndex: '↑',
        bgColor: Colors.green,
        iconData: Icons.people));
    topList.add(ContactInfo(
        name: '标签',
        tagIndex: '↑',
        bgColor: Colors.blue,
        iconData: Icons.local_offer));
    topList.add(ContactInfo(
        name: '公众号',
        tagIndex: '↑',
        bgColor: Colors.blueAccent,
        iconData: Icons.person));
    loadData();
  }

  void loadData() async {
    //加载联系人列表
    rootBundle.loadString('mock/contacts.json').then((value) {
      List list = json.decode(value);
      list.forEach((v) {
        contactList.add(ContactInfo.fromJson(v));
      });
      _handleList(contactList);
    });
  }

  void _handleList(List<ContactInfo> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(contactList);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contactList);

    // add topList.
    contactList.insertAll(0, topList);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AzListView(
        data: contactList,
        itemCount: contactList.length,
        itemBuilder: (BuildContext context, int index) {
          ContactInfo model = contactList[index];
          return getWeChatListItem(
            context,
            model,
            defHeaderBgColor: Color(0xFFE5E5E5),
          );
        },
        physics: BouncingScrollPhysics(),
        susItemBuilder: (BuildContext context, int index) {
          ContactInfo model = contactList[index];
          if ('↑' == model.getSuspensionTag()) {
            return Container();
          }
          return Utils.getSusItem(context, model.getSuspensionTag());
        },
        indexBarData: ['↑', '☆', ...kIndexBarData],
        indexBarOptions: IndexBarOptions(
          needRebuild: true,
          ignoreDragCancel: true,
          downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
          downItemDecoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.green),
          indexHintWidth: 120 / 2,
          indexHintHeight: 100 / 2,
          indexHintDecoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Utils.getImgPath('ic_index_bar_bubble_gray')),
              fit: BoxFit.contain,
            ),
          ),
          indexHintAlignment: Alignment.centerLeft,
          indexHintChildAlignment: Alignment(-0.25, 0.0),
          //指示器 偏移
          indexHintOffset: Offset((1 / 7).sw, 0),
          // indexHintOffset: Offset(-20, 0),
        ),
      ),
    );
  }

  static Widget getWeChatListItem(
    BuildContext context,
    ContactInfo model, {
    double susHeight = 40,
    Color? defHeaderBgColor,
  }) {
    return getWeChatItem(context, model, defHeaderBgColor: defHeaderBgColor);
//    return Column(
//      mainAxisSize: MainAxisSize.min,
//      children: <Widget>[
//        Offstage(
//          offstage: !(model.isShowSuspension == true),
//          child: getSusItem(context, model.getSuspensionTag(),
//              susHeight: susHeight),
//        ),
//        getWeChatItem(context, model, defHeaderBgColor: defHeaderBgColor),
//      ],
//    );
  }

  static Widget getWeChatItem(
    BuildContext context,
    ContactInfo model, {
    Color? defHeaderBgColor,
  }) {
    DecorationImage? image;
//    if (model.img != null && model.img.isNotEmpty) {
//      image = DecorationImage(
//        image: CachedNetworkImageProvider(model.img),
//        fit: BoxFit.contain,
//      );
//    }
    return ListTile(
      leading: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4.0),
          color: model.bgColor ?? defHeaderBgColor,
          image: image,
        ),
        child: model.iconData == null
            ? null
            : Icon(
                model.iconData,
                color: Colors.white,
                size: 20,
              ),
      ),
      title: Text(model.name),
      onTap: () {
        // LogUtil.e("onItemClick : $model");
        Utils.showSnackBar(context, 'onItemClick : ${model.name}');
      },
    );
  }
}
