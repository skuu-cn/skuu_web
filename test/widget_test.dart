// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:intl/intl.dart';


void main() {
  String str = "2025-05-22T13:16+08:00";
  var format2 = DateFormat('HH:mm:ss');
  DateTime dateTime = DateTime.parse(str);
  String str1 =  format2.format(dateTime.toLocal());
  print(str1);
}