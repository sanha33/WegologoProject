import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashscreen/splashscreen.dart';

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
    return ScreenUtilInit(

        designSize: Size(376, 812),
        builder: ()=>
            GetMaterialApp(

              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
             // initialRoute: "/",
        //       routes: <String, WidgetBuilder>{
        //         '/LoginView' : (BuildContext context) => LoginPage()
        //       },
              getPages: [
                GetPage(name: "/", page:()=> LoginPage(),

                    //   MyDashBoard(),
                    binding: DashBoardBinding()

                )
              ],
               home: IntroScreen(),
            )
    );
  }
}


class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return new SplashScreen(
        useLoader: true,
      //  loadingTextPadding: EdgeInsets.all(0),
        loadingText: Text(""),
        navigateAfterSeconds: result != null ?  MyDashBoard() : LoginPage(),
        seconds: 5,
        title: new Text(
          'Welcome To Meet up!',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        image: Image.asset('assets/images/dart.png', fit: BoxFit.scaleDown),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        onClick: () => print("flutter"),
        loaderColor: Colors.red);
  }
}