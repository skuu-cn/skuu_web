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

  //时间格式，1：毫秒。2：秒
  int dateTypeSelect = 1;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
    _controller = TextEditingController(text: '$currentTimeStamp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("时间工具"),
        ),
        body: Center(
          child: Container(
            width: 0.5.sw,
            height: 0.5.sh,
            // color: Colors.greenAccent,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SelectableText(
                    "当前时间戳（毫秒）是： $currentTimeStamp",
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            currentTimeStamp =
                                DateTime.now().millisecondsSinceEpoch;
                          });
                        },
                        child: const Text('刷新'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            currentTimeStamp =
                                DateTime.now().millisecondsSinceEpoch;
                          });
                        },
                        child: const Text('转换'),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("时间戳："),
                      Container(
                          width: 230,
                          child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {},
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ))),
                      DropdownButton(
                        focusColor: Colors.transparent,
                        value: dateTypeSelect,
                        items: <DropdownMenuItem<int>>[
                          DropdownMenuItem(
                            value: 1,
                            child: Text(
                              "毫秒",
                              style: TextStyle(
                                  color: dateTypeSelect == 1
                                      ? Colors.greenAccent
                                      : Colors.grey),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text(
                              "秒",
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
                          });
                        },
                      )
                    ],
                  ),
                ]),
          ),
        ));
  }
}
