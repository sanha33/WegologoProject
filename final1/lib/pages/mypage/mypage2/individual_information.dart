import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Information extends StatelessWidget {
  // const Question({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(

          leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.black), onPressed: () { Get.back(); },),
          title: Text(
            '개인정보 처리방침',
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
                  Text("제 1장 총칙"),
                  Text("주식회사 위고레고(이하 회사) 는 고객님의 개인정보를 소중하게 생각하고 고객님의 개인정보를 효과적으로 관리하고 안전하게 보호하기 위하여 최선의 노력을 다 하고 있습니다. 회사는 정보통신망 이용촉진 및 정보보호 등에 관한 법률과 개인정보보호 관련 각종 법규를 준수하고 있습니다. 또한 개인정보취급방침을 제정하여 이를 준수하고 있으며, 본 취급방침을 홈페이지 공개하여 고객님께서 언제나 쉽게 열람하실 수 있도록 하고 있습니다."),

                  Text("1. 개인정보란 생존하는 개인에 관한 정보로서 성명, 생년월일, 성별 등에 의하여 당해 개인을 알아볼 수 있는 부호, 문자, 음성, 음향, 영상 및 생체 특성 등에 관한 정보(당해 정보만으로는 특정 개인을 알아볼 수 없는 경우에도 다른 정보와 용이하게 결합하여 알아볼 수 있는 것을 포함)을 말합니다."),
                  Text("2. 회사는 고객님의 개인정보를 중요시하며, 정보통신망 이용촉진 및 정보보호 등에 관한 법률 과 관련 법규를 준수하고 있습니다."),
                  Text("3. 회사는 개인정보취급방침을 통하여 고객님의 개인정보가 어떠한 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다."),
                  //Text("3. 본 약관은 회사가 필요하다고 인정되는 경우 대한민국 법령의 범위 내에는 개정할 수 있으며, 회사가 약관을 개정할 경우에는 적용예정일 및 개정사유를 명시하여 현행약관과 함께 서비스 초기화면에 그 적용예정일 7일 전부터 공지합니다. 다만, 회원에게 불리하게 약관 내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지하는 것 외에 이메일 발송 등 전자적 수단을 통해 별도로 통지합니다. ")

                ],
              ),
            )
        )
    );
  }
}