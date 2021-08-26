import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Terms extends StatelessWidget {
  // const Question({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(

          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black), onPressed: () { Get.back(); },),
          title: Text(
            '이용 약관',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: Container(
              width: 300,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("제 1조(목적)"),
                  Text("본 약관은 주식회사 고위고레고(이하 회사)가 제공하는 olleh bizmeka EZ(이하 서비스)를 이용함에 있어 회사와 회원간의 권리, 의무 및 책임사항, 기타 필요한 사항등을 규정함을 목적합니다."),

                  Text("제 2조(약관의 효력, 개정 및 해석)"),
                  Text("1. 본 약관의 내용은 서비스 화면에 게시하거나 기타의 방법으로 회원에게 공시하고, 이에 동의한 회원이 서비스에 가입함으로써 효력이 발생합니다. "),
                  Text("2. 회사는 본 약관의 내용과 회사의 상호, 영업소 소재지, 대표자 성명, 사업자 등록번호등을 회원이 알 수 있도록 서비스 초기 화면에 게시합니다. "),
                  Text("3. 본 약관은 회사가 필요하다고 인정되는 경우 대한민국 법령의 범위 내에는 개정할 수 있으며, 회사가 약관을 개정할 경우에는 적용예정일 및 개정사유를 명시하여 현행약관과 함께 서비스 초기화면에 그 적용예정일 7일 전부터 공지합니다. 다만, 회원에게 불리하게 약관 내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지하는 것 외에 이메일 발송 등 전자적 수단을 통해 별도로 통지합니다. ")

                ],
              ),
            )
        )
    );
  }
}