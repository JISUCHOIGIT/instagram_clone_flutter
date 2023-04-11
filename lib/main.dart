import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:instagram_clone_flutter/src/app.dart';
import 'package:instagram_clone_flutter/src/binding/init_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Get 사용시 GetMaterialApp으로 감싸기
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // appBarTheme : 전체적인 AppBar 테마 색상 지정
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle:TextStyle(color: Colors.black),

        ),
      ),
      initialBinding: InitBinding(),
      home: const App(),
    );
  }
}


