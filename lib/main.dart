import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/activity/home.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: 'Flutter News App',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
