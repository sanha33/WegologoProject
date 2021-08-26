import 'package:getx_bottom_navigation_bar/agorafunc/call_taker.dart';
import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Thank extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _toolbar(context),
          _thankdialog(context),
        ],
      ),
    );
  }

  // Widget _turnoffcamera() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //         image: NetworkImage("https://i.ibb.co/nsVhXLq/black-background.jpg"),
  //         fit: BoxFit.cover,
  //         colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
  //       ),
  //     ),
  //     child: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(30),
  //             child: Text(
  //               "카메라가 꺼져있습니다",
  //               style: TextStyle(
  //                 color: Color(0xffffffff),
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //           Text(
  //             "Helper와 음성으로 도움을 받으세요!",
  //             style: TextStyle(
  //               color: Color(0xff979797),
  //               fontSize: 14,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget _toolbar(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.videocam_off,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: () {},
            child: Icon(
              Icons.mic_off,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 4.0,
            fillColor: Colors.blueAccent,
            padding: const EdgeInsets.all(12.0),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: MaterialButton(
              minWidth: 0,
              onPressed: () async {},
              child: Icon(
                Icons.favorite,
                color: Color(0xffe82b50),
                size: 45.0,
              ),
              padding: const EdgeInsets.all(12.0),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget _thankdialog(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width * 0.96,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Helper',
                        style: TextStyle(
                          color: Color(0xffef7b7b),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '와의 통화가 종료되었습니다.',
                        style: TextStyle(
                          color: Color(0xff868e96),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.018,
                  ),
                  Text(
                    '도움이 되셨나요?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ), 
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.036,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //하트 같은거 보내는 기능
                        Get.off(()=>MyDashBoard(),
                            transition: Transition.leftToRight);
                        //Get.back();
                      },
                      icon: Icon(
                        Icons.sentiment_satisfied_alt_rounded,
                        color: Colors.black,
                      ),
                      label: Text(
                        '네! 궁금증이 완전히 해결되었어요',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xffFCF3CA),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.82,
                    height: MediaQuery.of(context).size.height * 0.06,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        //다시 연결하는 등의 표시
                        Get.off(
                          CallPage_taker(),
                          transition: Transition.noTransition,
                        );
                      },
                      icon: Icon(
                        Icons.sentiment_dissatisfied_rounded,
                        color: Colors.black,
                      ),
                      label: Text(
                        '아직 도움이 필요해요',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xffF1F3F5),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
