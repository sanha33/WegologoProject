import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:wegolego_ui/nav.dart';

// class WelcomeView extends GetView<WelcomeController> {
//   late String _channelController; // ㅇㅕㄱ에 사용자 uid insert
//   //String? _channelController;
//   bool _validateError = false;
//   ClientRole? _role = ClientRole.Broadcaster;
//
//   // void initState(){
//   //   _channelController = controller.user.uid;
//   // }
//
//   // realtime database
//   get app => null;
//   final referenceDatabase = FirebaseDatabase.instance;
//   final uid = 'uid';
//   late DatabaseReference _uidRef;
//   bool dialog_screen = false;
//
//   @override
//   void initState() {
//     final FirebaseDatabase database = FirebaseDatabase(app: this.app);
//     _uidRef = database.reference().child('Uids');
//
//     initState();
//   }

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final ref = referenceDatabase.reference();
    int? value1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 33.0,
        title: Text(
          "MooMooL",
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0, 0, 12.0, 0),
            onPressed: () {},
            //추가적인 안내가 없다면 Icons.notifications
            icon: Icon(Icons.notifications_active),
            iconSize: 22.0,
          )
        ],
      ),

      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      MediaQuery.of(context).size.height * 0.25,
                      0,
                      MediaQuery.of(context).size.height * 0.25,
                    ),
                    width: MediaQuery.of(context).size.width,
                    //height:
                    color: Color(0xffFCF3CA),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '233,564',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              '명의',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'helper',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '가 참여하고 있습니다.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //WheelExample(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.37,
                      ),
                      Container(
                        padding: EdgeInsets.all(13),
                        width: MediaQuery.of(context).size.width * 0.4,
                        //157,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                             // Get.bottomSheet(WheelExample());
                            },
                            child: Text(
                              'Ask',
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 32,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(20),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
          //이부분에 기존 코드가 들어감
        ),
      ),
    );
  }

  // @override
  // Widget select(BuildContext context) {
  //   return Container(
  //     child: ElevatedButton(
  //       onPressed: () {},
  //       child: Text('무언가?'),
  //       style: ElevatedButton.styleFrom(
  //         shape: CircleBorder(),
  //         padding: EdgeInsets.all(20),
  //       ),
  //     ),
  //   );
  // }
//
//   Future<void> onJoin() async {
//     _channelController = controller.user.uid;
//     print("Uid(ChannelName): ${_channelController}");
//     // update input validation
//     // setState(() {
//     //   _channelController.text.isEmpty
//     //       ? _validateError = true
//     //       : _validateError = false;
//     // });
//     if (_channelController.isNotEmpty) {
//       print("Not Empty");
//       // await for camera and mic permissions before pushing video page
//       await _handleCameraAndMic(Permission.camera);
//       await _handleCameraAndMic(Permission.microphone);
//       // push video page with given channel name
//       await Get.to(() => CallPage(
//         channelName: _channelController,
//         role: _role,
//       ));
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => CallPage(
//       //       channelName: _channelController,
//       //       role: _role,
//       //     ),
//       //   ),
//       // );
//     }
//   }
//
//   Future<void> _handleCameraAndMic(Permission permission) async {
//     final status = await permission.request();
//     print(status);
//   }
 }