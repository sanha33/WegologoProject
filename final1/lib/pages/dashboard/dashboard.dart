import 'package:getx_bottom_navigation_bar/pages/home/home_page.dart';
import 'package:getx_bottom_navigation_bar/pages/askboard/askboard_page.dart';
import 'package:getx_bottom_navigation_bar/pages/mypage/mypage_page.dart';
import 'package:flutter/material.dart';

import '../../navigation/custom_animated_bottom_bar.dart';

import 'package:getx_bottom_navigation_bar/pages/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class MyDashBoard extends StatefulWidget {
  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {


  final _inactiveColor = Colors.grey;

  int _currentIndex = 0;

  final List<Widget> _children = [AskBoardPage(), HomePage(), MyPage()];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(builder: (controller) {
      return Scaffold(

          body:  _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _onTap,
          currentIndex: _currentIndex,

            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text(
                  'Messages ',
                ),

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text('Home'),

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                title: Text('Users'),

              ),

            ],

        ),
      );
    });
  }


}
