import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';
import 'package:getx_bottom_navigation_bar/main.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
class WelcomePage extends StatefulWidget {
  //final SignInEmailAndPassword signInEmailAndPassword =
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void>mumulSignOut() async {
    await FirebaseAuth.instance.signOut();
  //  await googleSignIn.disconnect();
   // await googleSignIn.signOut();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyApp()), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child:ElevatedButton(

          style:  ElevatedButton.styleFrom(
            primary: Color(0XFF7EA68D),
            shape: RoundedRectangleBorder( //to set border radius to button
              borderRadius: BorderRadius.circular(10),
            ),),
          child: Text(
            "Logout",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: mumulSignOut,
        )
    );
  }
}
