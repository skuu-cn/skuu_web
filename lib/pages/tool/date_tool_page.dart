import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateToolPage extends StatefulWidget {
  const DateToolPage({super.key});

  @override
  State createState() {
    return _DateToolPage();
  }
}

class _DateToolPage extends State<DateToolPage> {
  late int currentTimeStamp;
  late String currentTime;

  //时间格式，1：毫秒。2：秒
  int secondTypeSelect = 1;

  //日期格式，1：时间。2：日期
  int dateTypeSelect = 1;
  late TextEditingController _controller;
  late TextEditingController dateController;

  @override
  void initState() {
    super.initState();
    currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    _controller = TextEditingController(text: '$currentTimeStamp');
    currentTime = timestampToDateStr(currentTimeStamp);
    dateController = TextEditingController(text: '$currentTime');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("时间工具"),
        ),
        body: Center(
          child: SizedBox(
            width: 0.5.sw,
            height: 0.5.sh,
            // color: Colors.greenAccent,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText.rich(
                      style: TextStyle(fontSize: 20),
                      TextSpan(children: [
                        TextSpan(text: "当前时间戳（毫秒）："),
                        TextSpan(text: "$currentTimeStamp"),
                      ])),
                  Container(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        secondChange();
                        dateChange();
                      });
                    },
                    child: const Text('刷新'),
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("时间戳："),
                      SizedBox(
                          width: 210,
                          child: TextField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              maxLength: secondTypeSelect == 1 ? 13 : 10,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    _controller.clear();
                                  },
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ))),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                        focusColor: Colors.transparent,
                        value: secondTypeSelect,
                        items: <DropdownMenuItem<int>>[
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "毫秒",
                              style: TextStyle(
                                  color: secondTypeSelect == 1
                                      ? Colors.greenAccent
                                      : Colors.grey),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              "秒",
                              style: TextStyle(
                                  color: secondTypeSelect == 2
                                      ? Colors.greenAccent
                                      : Colors.grey),
                            ),
                          ),
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            secondTypeSelect = value!;
                            secondChange();
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (int.tryParse(_controller.text) == null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const AlertDialog(
                                    content: Text("请输入正确的时间戳"));
                              },
                            );
                          } else {
                            setState(() {
                              int inputTimeStamp = int.parse(_controller.text);
                              dateController = TextEditingController(
                                  text: timestampToDateStr(inputTimeStamp));
                            });
                          }
                        },
                        child: const Text('转日期'),
                      ),
                    ],
                  ),
                  Container(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("时间  ："),
                      SizedBox(
                          width: 250,
                          child: TextField(
                              controller: dateController,
                              keyboardType: TextInputType.datetime,
                              maxLength: dateTypeSelect == 1 ? 19 : 10,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    dateController.clear();
                                  },
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ))),
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButton(
                        focusColor: Colors.transparent,
                        value: dateTypeSelect,
                        items: <DropdownMenuItem<int>>[
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "时间",
                              style: TextStyle(
                                  color: dateTypeSelect == 1
                                      ? Colors.greenAccent
                                      : Colors.grey),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              "日期",
                              style: TextStyle(
                                  color: dateTypeSelect == 2
                                      ? Colors.greenAccent
                                      : Colors.grey),
                            ),
                          ),
                        ],
                        onChanged: (int? value) {
                          setState(() {
                            dateTypeSelect = value!;
                            dateChange();
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            var strtimes = DateTime.parse(dateController.text);
                            if (secondTypeSelect == 1) {
                              currentTimeStamp =
                                  strtimes.millisecondsSinceEpoch;
                            } else {
                              currentTimeStamp =
                                  (strtimes.millisecondsSinceEpoch / 1000)
                                      .truncate();
                            }
                            _controller = TextEditingController(
                                text: '$currentTimeStamp');
                          });
                        },
                        child: const Text('转时间戳'),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }

  static String timestampToDateStr(int timestamp, {onlyNeedDate = false}) {
    DateTime dataTime = timestampToDate(timestamp);
    String dateTime = dataTime.toString();

    ///去掉时间后面的.000
    dateTime = dateTime.substring(0, dateTime.length - 4);
    if (onlyNeedDate) {
      List<String> dataList = dateTime.split(" ");
      dateTime = dataList[0];
    }
    return dateTime;
  }

  static DateTime timestampToDate(int timestamp) {
    DateTime dateTime = DateTime.now();

    ///如果是十三位时间戳返回这个
    if (timestamp.toString().length == 13) {
      dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    } else if (timestamp.toString().length == 16) {
      ///如果是十六位时间戳
      dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    }
    return dateTime;
  }

  void secondChange() {
    if (secondTypeSelect == 1) {
      currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
      _controller = TextEditingController(text: '$currentTimeStamp');
    } else {
      currentTimeStamp =
          (DateTime.now().millisecondsSinceEpoch / 1000).truncate();
    }
    _controller = TextEditingController(text: '$currentTimeStamp');
  }

  void dateChange() {
    if (dateTypeSelect == 1) {
      currentTime = timestampToDateStr(currentTimeStamp, onlyNeedDate: false);
    } else {
      currentTime = timestampToDateStr(currentTimeStamp, onlyNeedDate: true);
    }
    dateController = TextEditingController(text: '$currentTime');
  }
}
