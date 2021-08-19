import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:agora_channel_realtimedb/app/modules/home/controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "images/app_logo.png",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Google SignIn",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: SignInButton(
                Buttons.Google,
                onPressed: (){
                      controller.login();
                    }
                  ),
                  // child: ConstrainedBox(
                  //   constraints: BoxConstraints.tightFor(width: context.width),
                  //   child: ElevatedButton(
                  //     child: Text(
                  //       "Sign In with Google",
                  //       style: TextStyle(fontSize: 18, color: Colors.black),
                  //     ),
                  //     onPressed: () {
                  //       controller.login();
                  //     },
                  //   ),
                  // ),
                  ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}