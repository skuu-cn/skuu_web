import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skuu/app/data/models/address_entity.dart';

import '../../../../constant/color_constant.dart';
import '../../../components/video_player_public/public_video_player.dart';
import '../../index/views/filter_page.dart';

class PublicShortVideoPage extends StatefulWidget {
  PublicShortVideoPage();

  @override
  State<StatefulWidget> createState() {
    return _PublicShortVideoPage();
  }
}

class _PublicShortVideoPage extends State<PublicShortVideoPage> {
  //菜单和路由
  final publishController = TextEditingController();

  late List<XFile> files = [];
  List<XFile> videoFiles = [];
  List<AddressEntity> addressList = [];
  List<String> whoCanSee = [];

  late AddressEntity? selAddressEntity = null;
  late String? whoCanSeeSel = '';
  late List<String> huatiSel = [];

  @override
  void initState() {
    super.initState();
    loadAddressData();
    whoCanSee.addAll([
      '公开',
      '私密',
      '仅好友可看',
    ]);
  }

  void loadAddressData() async {
    //加载联系人列表
    rootBundle.loadString('mock/address.json').then((value) {
      List list = json.decode(value);
      list.forEach((v) {
        addressList.add(AddressEntity.fromJson(v));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('发布短视频'), actions: [
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
        body: ListView(
          padding: EdgeInsets.all(5),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Wrap(
                children: [
                  ...files.map(
                        (XFile file) => Container(
                      padding: EdgeInsets.all(5),
                      width: videoFiles.isEmpty ? 0.3.sw : 300,
                      height: videoFiles.isEmpty ? 0.3.sw : 300,
                      child: Stack(
                        children: [
                          videoFiles.isEmpty
                              ? Positioned.fill(
                            child: kIsWeb
                                ? Image.network(
                              // width: 0.3.sw,
                              // height: 0.3.sw,
                              file.path,
                              fit: BoxFit.fill,
                            )
                                : Image.file(File(file.path)),
                          )
                              : Positioned.fill(
                            child: PublicVideoPlayer(),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton.filled(
                                onPressed: () {
                                  setState(() {
                                    files.remove(file);
                                    videoFiles.clear();
                                  });
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (files.length < 6 && videoFiles.isEmpty)
                    InkWell(
                      onTap: () {
                        // setState(() {});
                        _openImageFile(context).then((value) => {
                          setState(() {
                            if (files.isNotEmpty && videoFiles.isNotEmpty) {
                              videoFiles.clear();
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                desc: '请上传图片',
                                btnOkOnPress: () {},
                              )..show();
                              return;
                            }
                            if (files.length + value.length > 6) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                desc: '图片超出最大限制：6个',
                                btnOkOnPress: () {},
                              )..show();
                              return;
                            }
                            if (value.isNotEmpty) {
                              files.addAll(value);
                            }
                          })
                        });
                      },
                      child: Icon(
                        Icons.add_box,
                        size: 0.3.sw,
                        color: Colors.black12,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            TextField(
              minLines: 5,
              maxLines: 10,
              controller: publishController,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                ///设置输入文本框的提示文字
                ///输入框获取焦点时 并且没有输入文字时
                hintText: "视频介绍",

                ///设置输入文本框的提示文字的样式
                hintStyle: TextStyle(
                  color: Colors.grey,
                  textBaseline: TextBaseline.ideographic,
                ),

                ///输入框内的提示 输入框没有获取焦点时显示
                labelText: "视频介绍",
                labelStyle: TextStyle(color: Colors.black),

                ///输入框获取焦点时才会显示出来 输入文本的前面
                prefixText: "介绍：",
                prefixStyle: TextStyle(color: Colors.deepPurple),

                ///输入文字后面的小图标
                suffixIcon: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    publishController.clear();
                  },
                ),

                ///设置边框
                ///   InputBorder.none 无下划线
                ///   OutlineInputBorder 上下左右 都有边框
                ///   UnderlineInputBorder 只有下边框  默认使用的就是下边框
                border: OutlineInputBorder(
                  ///设置边框四个角的弧度
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                  ///用来配置边框的样式
                  borderSide: BorderSide(
                    ///设置边框的颜色
                    color: Colors.red,

                    ///设置边框的粗细
                    width: 2.0,
                  ),
                ),

                ///设置输入框可编辑时的边框样式
                enabledBorder: OutlineInputBorder(
                  ///设置边框四个角的弧度
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                  ///用来配置边框的样式
                  borderSide: BorderSide(
                    ///设置边框的颜色
                    color: Colors.grey,

                    ///设置边框的粗细
                    width: 2.0,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  ///设置边框四个角的弧度
                  borderRadius: BorderRadius.all(Radius.circular(10)),

                  ///用来配置边框的样式
                  borderSide: BorderSide(
                    ///设置边框的颜色
                    color: Colors.red,

                    ///设置边框的粗细
                    width: 2.0,
                  ),
                ),

                ///用来配置输入框获取焦点时的颜色
                focusedBorder: OutlineInputBorder(
                  ///设置边框四个角的弧度
                  borderRadius: BorderRadius.all(Radius.circular(20)),

                  ///用来配置边框的样式
                  borderSide: BorderSide(
                    ///设置边框的颜色
                    color: Colors.green,

                    ///设置边框的粗细
                    width: 2.0,
                  ),
                ),
              ),
            ),

            Divider(
              height: 1,
              color: Colors.black12,
              indent: 20,
              endIndent: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    constraints: BoxConstraints(maxHeight: 0.8.sh),
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext build) {
                      return Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: ListView.separated(
                          itemCount: addressList.length,
                          itemBuilder: (BuildContext context, int index) {
                            AddressEntity addressEntity = addressList[index];
                            String detail = addressEntity.detail;
                            String distance = addressEntity.distance;
                            return ListTile(
                              title: Text(addressEntity.name),
                              subtitle: index == 0
                                  ? null
                                  : Text(
                                '$detail | $distance',
                                style: TextStyle(color: Colors.grey),
                              ),
                              trailing:
                              selAddressEntity?.name == addressEntity.name
                                  ? Icon(Icons.check)
                                  : null,
                              onTap: () {
                                setState(() {
                                  selAddressEntity = addressEntity;
                                  Navigator.pop(context);
                                });
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(height: 1.0, color: Colors.grey),
                        ),
                      );
                    });
              },
              child: selAddressEntity == null
                  ? const ListTile(
                leading: Icon(Icons.add_location),
                title: Text('所在位置'),
                trailing: Icon(Icons.chevron_right),
              )
                  : ListTile(
                leading: Icon(Icons.add_location),
                title: Text(selAddressEntity!.name),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black12,
              indent: 20,
              endIndent: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    constraints: BoxConstraints(maxHeight: 0.8.sh),
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext build) {
                      return Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: ListView.separated(
                          itemCount: addressList.length,
                          itemBuilder: (BuildContext context, int index) {
                            AddressEntity addressEntity = addressList[index];
                            String detail = addressEntity.detail;
                            String distance = addressEntity.distance;
                            return ListTile(
                              title: Text(addressEntity.name),
                              subtitle: index == 0
                                  ? null
                                  : Text(
                                      '$detail | $distance',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                              trailing:
                                  selAddressEntity?.name == addressEntity.name
                                      ? Icon(Icons.check)
                                      : null,
                              onTap: () {
                                setState(() {
                                  selAddressEntity = addressEntity;
                                  Navigator.pop(context);
                                });
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(height: 1.0, color: Colors.grey),
                        ),
                      );
                    });
              },
              child: selAddressEntity == null
                  ? ListTile(
                      leading: Icon(Icons.video_library),
                      title: Text('发布到剧集'),
                      trailing: Icon(Icons.chevron_right),
                    )
                  : ListTile(
                      leading: Icon(Icons.category),
                      title: Text(selAddressEntity!.name),
                      trailing: Icon(Icons.chevron_right),
                    ),
            ),
            Divider(
              height: 1,
              color: Colors.black12,
              indent: 20,
              endIndent: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    constraints: BoxConstraints(maxHeight: 0.8.sh),
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext build) {
                      return FilterPage(huatiSel);
                    }).then((value) {
                      if(value != null){
                        setState(() {
                          huatiSel = value;
                        });
                      }
                });
              },
              child: ListTile(
                leading: Icon(Icons.category),
                title: huatiSel.isEmpty ? Text('分类') : Text(huatiSel.join(",")),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black12,
              indent: 20,
              endIndent: 20,
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                    constraints: BoxConstraints(minHeight: 0.8.sh),
                    context: context,
                    builder: (BuildContext build) {
                      return Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: ListView.separated(
                          itemCount: whoCanSee.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(whoCanSee[index]),
                              trailing: whoCanSeeSel == whoCanSee[index]
                                  ? Icon(Icons.check)
                                  : null,
                              onTap: () {
                                setState(() {
                                  whoCanSeeSel = whoCanSee[index];
                                  Navigator.pop(context);
                                });
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(height: 1.0, color: Colors.grey),
                        ),
                      );
                    });
              },
              child: ListTile(
                leading: Icon(Icons.perm_identity),
                title:
                    whoCanSeeSel!.isEmpty ? Text('谁可以看') : Text(whoCanSeeSel!),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        ));
  }

  Future<List<XFile>> _openImageFile(BuildContext context) async {
    // #docregion MultiOpen
    const XTypeGroup jpgsTypeGroup = XTypeGroup(
      label: 'JPEGs',
      extensions: <String>['jpg', 'jpeg'],
    );
    const XTypeGroup pngTypeGroup = XTypeGroup(
      label: 'PNGs',
      extensions: <String>['png'],
    );
    List<String> videoList = ['mp3', 'mp4'];
    const XTypeGroup videoTypeGroup = XTypeGroup(
      label: 'video',
      extensions: <String>['mp3', 'mp4'],
    );
    final List<XFile> files = await openFiles(acceptedTypeGroups: <XTypeGroup>[
      // jpgsTypeGroup,
      // pngTypeGroup,
      videoTypeGroup
    ]);
    // #enddocregion MultiOpen
    if (files.isEmpty) {
      // Operation was canceled by the user.
      return Future.value([]);
    }
    files.forEach((element) {
      String suf = element.name.split(".").last;
      if (videoList.contains(suf)) {
        videoFiles.add(element);
        return;
      }
    });

    if (context.mounted) {
      return Future.value(videoFiles.isNotEmpty ? videoFiles : files);
    }
    return Future.value([]);
  }
}
