import 'package:flutter/material.dart';
import 'package:wallpaper_app/wallpaper.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        color: Colors.black,
      )),
      home: wallpaper(),
    );
  }

}