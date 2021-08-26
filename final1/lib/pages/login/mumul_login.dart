import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';
import 'package:getx_bottom_navigation_bar/pages/login/mumul_sign_up.dart';
import 'package:getx_bottom_navigation_bar/pages/login/welcome.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_bottom_navigation_bar/pages/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_page.dart';


class MumulLogin extends StatefulWidget {
  const MumulLogin({Key? key}) : super(key:key);
  @override
  _MumulLoginState createState() => _MumulLoginState();
}

class _MumulLoginState extends State<MumulLogin> {
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  bool _obscuretext = true;

  @override
  initState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            }, icon:  Icon(Icons.arrow_back), color: Colors.black)
        ),
        body:
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            child: Form(
              // padding: EdgeInsets.all(48),
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox (
                      height:(30)
                  ),
                  Text('이메일'),
                  TextFormField(
                    validator:  (val)=> val!.length < 1 ? '이메일을입력하세요. ' : null,
                    decoration: InputDecoration(
                      hintText: 'wegolego@mumul.com',
                      hintStyle: TextStyle(
                          color: Color(0XFF7EA68D)
                      ),),
                    controller: emailController,
                  ),
                  SizedBox (
                      height: (30)
                  ),
                  Text('비밀번호'),
                  TextFormField(
                    validator: (val)=> val!.length < 8 ? '비. ' : null,
                    obscureText: _obscuretext,
                    decoration: InputDecoration(
                      hintText: '8자리 이상',
                      hintStyle: TextStyle(
                          color: Color(0XFF7EA68D)
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                        ),
                        onPressed: (){
                          setState(() {
                            _obscuretext = !_obscuretext;
                          });
                          // _controller.obscureChange;
                        },
                      ),
                    ),
                    controller: passwordController,
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                            SignupView()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('회원가입'),
                        ],
                      )),
                  SizedBox(height: (80),),

                  Center(
                    child: SizedBox(
                      height: (50),
                      width: (280),

                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0XFF7EA68D),
                          ),
                          child: Text('로그인'),
                          onPressed
                              :() async {
                            if (_key.currentState!.validate()) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text
                                );

                              } on FirebaseAuthException catch (error) {
                                // errorMessage = error.message!;
                              }
                              var fbUser= FirebaseAuth.instance.currentUser;
                              print(fbUser!.email);
                              if(fbUser != null){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                                    MyDashBoard()));
                              }
                            }

                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }}