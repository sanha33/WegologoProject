import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_controller.dart';

import 'package:getx_bottom_navigation_bar/agorafunc/call_helper.dart';
import 'package:getx_bottom_navigation_bar/agorafunc/call_taker.dart';
import 'package:getx_bottom_navigation_bar/pages/askboard_list/askboard_list_page.dart';
import 'package:getx_bottom_navigation_bar/pages/home/home_page.dart';
import 'package:getx_bottom_navigation_bar/pages/askboard/askboard_page.dart';
import 'package:getx_bottom_navigation_bar/pages/mypage/mypage_page.dart';
import '../../navigation/custom_animated_bottom_bar.dart';
import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';


class HomePage extends GetView<HomePageController> {

  HomePageController homeController = Get.find<HomePageController>();


  late String _channelController; // ㅇㅕㄱ에 사용자 uid insert
  //String? _channelController;
  bool _validateError = false;
  ClientRole? _role = ClientRole.Broadcaster;

  // void initState(){
  //   _channelController = controller.user.uid;
  // }

  // realtime database
  get app => null;
  final referenceDatabase = FirebaseDatabase.instance;
  final uid = 'uid';
  late DatabaseReference _uidRef;

  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase(app: this.app);
    _uidRef = database.reference().child('Uids');

    initState();
  }



  @override
  Widget build(BuildContext context) {


    final _inactiveColor = Colors.grey;
    final ref = referenceDatabase.reference();



    return Scaffold(

      appBar: AppBar(
        title: Text(
          'MooMool',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
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
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   onTap: _onTap,
      //   currentIndex: _currentIndex,
      //   items: [
      //     BottomNavigationBarItem(
      //       title: Text('Favorites'),
      //       icon: Icon(Icons.favorite),
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('Music'),
      //       icon: Icon(Icons.music_note),
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('Places'),
      //       icon: Icon(Icons.location_on),
      //     ),
      //     BottomNavigationBarItem(
      //       title: Text('News'),
      //       icon: Icon(Icons.library_books),
      //     ),
      //   ],
      //
      // ),
      // bottomNavigationBar: CustomAnimatedBottomBar(
      //   containerHeight: 70,
      //   backgroundColor: Colors.white,
      //   selectedIndex: homeController.tabIndex,
      //   showElevation: true,
      //   itemCornerRadius: 24,
      //   curve: Curves.easeIn,
      //   onItemSelected: homeController.changeTabIndex,
      //
      //   items: <BottomNavyBarItem>[
      //     BottomNavyBarItem(
      //       icon: Icon(Icons.message),
      //       title: Text(
      //         'Messages ',
      //       ),
      //       activeColor: Colors.pink,
      //       inactiveColor: _inactiveColor,
      //       textAlign: TextAlign.center,
      //     ),
      //     BottomNavyBarItem(
      //       icon: Icon(Icons.apps),
      //       title: Text('Home'),
      //       activeColor: Colors.green,
      //       inactiveColor: _inactiveColor,
      //       textAlign: TextAlign.center,
      //     ),
      //     BottomNavyBarItem(
      //       icon: Icon(Icons.people),
      //       title: Text('Users'),
      //       activeColor: Colors.purpleAccent,
      //       inactiveColor: _inactiveColor,
      //       textAlign: TextAlign.center,
      //     ),
      //
      //
      //   ],
      // ),
      body: SingleChildScrollView(
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
                              Get.bottomSheet(Popup());
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
                              primary: Colors.white,
                            )),


                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await Get.to(() => ListPage()

                          );
                        },
                        child: Center(
                          child: Text(
                            "Channel List",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      )
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
  Future<void> onJoin() async {
    _channelController = homeController.user.uid;
    print("Uid(ChannelName): ${_channelController}");
    // update input validation
    // setState(() {
    //   _channelController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
    if (_channelController.isNotEmpty) {
      print("Not Empty");
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Get.to(() => CallPage_taker(
        channelName: _channelController,
      //  role: _role,
      ));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CallPage(
      //       channelName: _channelController,
      //       role: _role,
      //     ),
      //   ),
      // );
    }
  }


  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}



class Popup extends GetView<HomePageController>{
  late String _channelController ;
  HomePageController homeController = Get.find<HomePageController>();

  final _scrollController = FixedExtentScrollController();

  static const double _itemHeight = 60;
  static const int _itemCount = 6;
  late int tap_question;
  int which_question = 0;
  late bool textbox;
  final referenceDatabase = FirebaseDatabase.instance;
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();

    return Container(
      child: ClickableListWheelScrollView(
        scrollController: _scrollController,
        itemHeight: _itemHeight,
        itemCount: _itemCount,
        onItemTapCallback: (index) {
          tap_question = index;
          if (tap_question == 5) {
            textbox = true;
          } else {
            textbox = false;
          }
          if (tap_question == which_question) {
            Get.defaultDialog(
              title: "${title_name[tap_question]} 질문을 하시겠습니까?",
              // middleText: "",
              //backgroundColor:
              // titleStyle:
              textConfirm: "네!",
              textCancel: "아니요!",
              // confirmTextColor:
              // cancelTextColor:
              buttonColor: Colors.amber,
              radius: 10,
              content: textbox
                  ? TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: '도움받고 싶은 내용을 입력하세요',
                ),
              )
                  : Text("Helper와 연결하려면 '네!'를 클릭해주세요"),
              onConfirm: () async {
                if (textbox) {
                  if (_textController.text.isNotEmpty) {
                  // print(_textController.text);

                    //Get.off(CallPage_taker());

                    _channelController = homeController.user.uid;
                    print("UID(Channel Name): ${_channelController}");

                    ref
                        .child('Uids')
                        .push()
                        .update({'uid': _channelController}).asStream();

                    if (_channelController.isNotEmpty) {
                      //print("UID is Channel");
                      // await for camera and mic permissions before pushing video page
                      await _handleCameraAndMic(Permission.camera);
                      await _handleCameraAndMic(Permission.microphone);
                      // push video page with given channel name
                      await Get.to(() => CallPage_taker(
                        channelName: _channelController,
                        //  role: _role,
                      ));
                    }


                  } else {
                    Get.defaultDialog(
                        title: "도움 입력하세요", middleText: "도움 입력하세요");
                  }
                } else {
                  print(_textController.text);
                  Get.off(CallPage_taker());
                }
              },
            );
          }
        },
        child: ListWheelScrollView.useDelegate(
          controller: _scrollController,
          itemExtent: _itemHeight,
          physics: FixedExtentScrollPhysics(),
          overAndUnderCenterOpacity: 0.5,
          perspective: 0.002,
          onSelectedItemChanged: (index) {
            //다 움직이고 이거에 대한 번호를 같이 보내어서 필요한 도움이 필요하게 해야함
            print("이동 index: $index");
            which_question = index;
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) => _child(index),
            childCount: _itemCount,
          ),
        ),
      ),
    );
  }

  List<String> icon_name = [
    '58169',
    '57821',
    '58608', //'58214',
    '58280',
    '61894',
    '58123',
  ];
  List<String> title_name = [
    '전자기기',
    '교통',
    '해외',
    '한동학교생활',
    '가벼운 질문',
    '기타',
  ];
  List<String> subtitle_name = [
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
    '에 관련해서 도움이 필요해요',
  ];

  Widget _child(int index) {
    return SizedBox(
      height: _itemHeight,
      child: ListTile(
        leading: Icon(
          IconData(
            int.parse("${icon_name[index]}"),
            fontFamily: 'MaterialIcons',
          ),
          size: 50,
        ),
        title: Text("${title_name[index]}"),
        subtitle: Text("${subtitle_name[index]}"),
        onTap: () {},
      ),
    );
  }

  Future<void> onJoin() async {
    _channelController = homeController.user.uid;
    print("Uid(ChannelName): ${_channelController}");
    // update input validation
    // setState(() {
    //   _channelController.text.isEmpty
    //       ? _validateError = true
    //       : _validateError = false;
    // });
    if (_channelController.isNotEmpty) {
      print("Not Empty");
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic(Permission.camera);
      await _handleCameraAndMic(Permission.microphone);
      // push video page with given channel name
      await Get.off(() => CallPage_taker(
        channelName: _channelController,
        //role: _role,
      ));
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => CallPage(
      //       channelName: _channelController,
      //       role: _role,
      //     ),
      //   ),
      // );
    }
  }


  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }


}
