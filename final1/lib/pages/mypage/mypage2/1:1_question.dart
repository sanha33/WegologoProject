import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Question extends StatelessWidget {
  // const Question({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black), onPressed: () { Get.back(); },),
          title: Text(
            '1:1 문의',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("wegolego21@gmail.com으로 문의하세요")
            ],
          ),
        )
    );
  }
}
