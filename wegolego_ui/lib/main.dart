import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wegolego_ui/askboard.dart';
import 'package:wegolego_ui/mypage.dart';
import 'package:wegolego_ui/notice.dart';
import 'package:wegolego_ui/home.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(376, 812),
        builder: () => GetMaterialApp(
          title: 'Wegolego',
          //여기서 theme 적용
         // theme: lightTheme1,
          home: MyPage(),


          //MyHomePage(title: 'Flutter Demo Home Page'),
        )

    );
  }
}