import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:get/get.dart';
import 'package:wegolego_ui/askboard_detail.dart';
import 'package:wegolego_ui/writepage.dart';
import 'package:wegolego_ui/nav.dart';

class AskBoard extends StatefulWidget {
  // const AskBoard({Key key}) : super(key: key);

  @override
  _AskBoardState createState() => _AskBoardState();
}

class _AskBoardState extends State<AskBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildListView(context),
      appBar: AppBar(
        title: Text(
          'Community',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    // bottomNavigationBar: Navigation(),
      floatingActionButton:buildMessageButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget buildMessageButton() => FloatingActionButton.extended(icon:Icon(Icons.message),
label: Text("Write"), onPressed: () async {
  await Get.to(() => WritePage());

});

Widget _buildListView(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),

    itemCount: 4,
    itemBuilder: (BuildContext context, int index) {
      final List<String> _title = [
        '교통카드 충전하는 법 좀 알려줭',
        '지하철 어떻게 타야해요 ?',
        '이게 뭐에요 ?',
        '어른들 제가 궁금한게 있는대요 ..'
      ];

      final List<String> _description = [
        '캐시피 교통카드인데 충전이 안돼요 ㅜ',
        '잠실로 가려면 여기서 어떻게 가야해요 ?',
        '이거 사용법을 모르겠어요 ',
        '저는 한동 초등학교 5학년이에요 인생은 어떻게 살아가는 거에요?'
      ];

      final List<String> _date = [
        '14:35 AM',
        '14:20 AM',
        '14:15 AM',
        '13:55 AM'
      ];

      final List<String> image = [
        '',
        '',
        'https://i.imgur.com/rKFhfY5.jpg',
        ''
      ];
      return Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ListTile(
              leading: Container(
                  width: 45.0,
                  height: 45.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              "https://i.imgur.com/BoN9kdC.png")))),
              // Container(
              //   width: MediaQuery.of(context).size.width / 4,
              //   height: 200,
              //   child: Image(
              //     image: NetworkImage("https://i.imgur.com/rKFhfY5.jpg"),
              //     width: 500,
              //     height: 200,
              //   ),
              // ),
              title: Text(
                _title[index],
                // style: body2Style(),
              ),
              subtitle: Text(
                _description[index],
              ),
              onTap: () async {
                await Get.to(() => AskBoardDetail(
                    title: _title[index],
                    description: _description[index],
                    date: _date[index]));
              },
              trailing: Text(_date[index]),
              //isThreeLine: true,
            ),
            // Container(
            //
            //     decoration: new BoxDecoration(
            //
            //         image: new DecorationImage(
            //             fit: BoxFit.fill,
            //             image: new NetworkImage(
            //                 image[index])
            //         )
            //     )),

            // SizedBox
            //   (height: 200,
            //     width: 200,
            //     child: Image.network(image[index])),

            Row(
              children: [
                SizedBox(width: 80.0),AnimatedContainer(
                  width: 60,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(13),
                  ),
                  duration: Duration(seconds: 1),
                  curve: Curves.fastOutSlowIn,
                  child: LikeButton(
                    size: 25.0,
                    circleColor: CircleColor(
                        start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.redAccent : Colors.grey,
                        size: 20.0,
                      );
                    },
                    likeCount: 65,
                    // countBuilder: (int count, bool isLiked, String text) {
                    //   var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                    //   Widget result;
                    //   if (count == 0) {
                    //     result = Text(
                    //       "love",
                    //       style: TextStyle(color: color),
                    //     );
                    //   } else
                    //     result = Text(
                    //       text,
                    //       style: TextStyle(color: color),
                    //     );
                    //   return result;
                    // },
                  ),
                    ),

                SizedBox(
                  width: 15.0,
                ),

                AnimatedContainer(
                    width: 50,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(13),
                    ),
                    duration: Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    child: LikeButton(
                      size: 25.0,
                      circleColor: CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.message,
                          color: isLiked ? Colors.blueGrey : Colors.grey,
                          size: 20.0,
                        );
                      },
                      likeCount: 4,
                    ),),

              ],
            ),
            SizedBox(height: 10.0),
            Divider(
              color: Colors.grey[20],
              thickness: 1.0,
            ),
          ],
        ),
      );
    },
  );
}
