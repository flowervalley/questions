import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:questions/course_list.dart';
import 'package:questions/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(const [
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Storage.init();
  runApp(MaterialApp(title: 'Questions', home: CourseList()));
}
