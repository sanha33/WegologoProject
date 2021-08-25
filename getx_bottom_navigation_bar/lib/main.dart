import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard_binding.dart';
import 'package:getx_bottom_navigation_bar/pages/login/login_controller.dart';
import 'package:getx_bottom_navigation_bar/pages/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getx_bottom_navigation_bar/pages/first/first_page.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DashBoardBinding().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page:()=> LoginPage(),

         //   MyDashBoard(),
        binding: DashBoardBinding()

        )
      ],
     // home: MyDashBoard(),
    );
  }
}
