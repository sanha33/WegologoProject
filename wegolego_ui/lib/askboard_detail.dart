import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wegolego_ui/askboard.dart';
import 'package:like_button/like_button.dart';

class AskBoardDetail extends StatelessWidget {
  late final String title;
  late final String description;
  late final String date;

  AskBoardDetail(
      {Key? key,
      required this.title,
      required this.description,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            'Community',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          //  margin: EdgeInsets.fromLTRB(0.0, 0, 0, 0),
          //color: thirdColor,
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(children: [
              Container(
                //margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: 45.0,
                                  height: 45.0,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              "https://i.imgur.com/BoN9kdC.png")))),
                              SizedBox(width: 10.0),
                              Column(
                                children: [
                                  Text(
                                    '마이쭈',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  Text('  $date'),
                                ],
                              ),
                            ],
                          ),
                          AnimatedContainer(
                              width: 100,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              duration: Duration(seconds: 1),
                              curve: Curves.fastOutSlowIn,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LikeButton(
                                    size: 25.0,
                                    likeBuilder: (bool isLiked) {
                                      return Icon(
                                        Icons.favorite,
                                        color: isLiked
                                            ? Colors.redAccent
                                            : Colors.black45,
                                        size: 20.0,
                                      );
                                    },
                                  ),
                                  Text('유용해요')
                                ],
                              )),

                          // Text(title, style: body2Style(color: onSurface[900])),
                        ],
                      ),

                      SizedBox(
                        height: 12.0,
                      ),
                      // new Container(
                      //   width: 900,
                      //   height: 240,
                      //   child: Image(
                      //     image: NetworkImage("https://i.imgur.com/rKFhfY5.jpg"),
                      //   ),
                      // )
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            //style: body3Style(color: onSurface[900]),
                            // textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 17.0),
                          ),
                          Text(
                            description,
                            //style: body3Style(color: onSurface[900]),
                            // textAlign: TextAlign.left,
                          )
                        ],
                      )),

                      SizedBox(
                        height: 20.0,
                      ),

//사진 넣기
                      Column(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              children: [
                                LikeButton(
                                  size: 25.0,
                                  circleColor: CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.favorite,
                                      color: isLiked
                                          ? Colors.redAccent
                                          : Colors.grey,
                                      size: 20.0,
                                    );
                                  },
                                  likeCount: 665,
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                LikeButton(
                                  size: 25.0,
                                  circleColor: CircleColor(
                                      start: Color(0xff00ddff),
                                      end: Color(0xff0099cc)),
                                  bubblesColor: BubblesColor(
                                    dotPrimaryColor: Color(0xff33b5e5),
                                    dotSecondaryColor: Color(0xff0099cc),
                                  ),
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.message,
                                      color: isLiked
                                          ? Colors.blueGrey
                                          : Colors.grey,
                                      size: 20.0,
                                    );
                                  },
                                  likeCount: 4,
                                ),
                              ],
                            ),
                          ),


                          SizedBox(
                            height: 10.0,
                          ),
                          Divider(
                            //  color: thirdColor[100],
                            thickness: 1.0,
                            // indent: 15,
                            // endIndent: 15,
                          ),
                          //여기서 부터 반복
                          SizedBox(height: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              width: 45.0,
                                              height: 45.0,
                                              decoration: new BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: new DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: new NetworkImage(
                                                          "https://i.imgur.com/BoN9kdC.png")))),
                                          SizedBox(width: 10.0),

                                          Column(
                                            children: [
                                              Text(
                                                '새콤달콤',
                                                style: TextStyle(fontSize: 18.0),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),


                                      Text('  $date'),
                                    ],
                                  )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('안됩니다 !!'),
                                  Row(
                                    children: [
                                      AnimatedContainer(
                                          width: 32,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              LikeButton(
                                                size: 25.0,
                                                likeBuilder: (bool isLiked) {
                                                  return Icon(
                                                    Icons.favorite,
                                                    color: isLiked
                                                        ? Colors.redAccent
                                                        : Colors.black45,
                                                    size: 20.0,
                                                  );
                                                },
                                              ),

                                            ],
                                          )),
                                      SizedBox(width: 10.0,),
                                      AnimatedContainer(
                                          width: 32,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              LikeButton(
                                                size: 25.0,
                                                likeBuilder: (bool isLiked) {
                                                  return Icon(
                                                    Icons.message,
                                                    color: isLiked
                                                        ? Colors.redAccent
                                                        : Colors.black45,
                                                    size: 20.0,
                                                  );
                                                },
                                              ),

                                            ],
                                          )),
      SizedBox(width: 10.0,),AnimatedContainer(
                                          width: 32,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              LikeButton(
                                                size: 25.0,
                                                likeBuilder: (bool isLiked) {
                                                  return Icon(
                                                    Icons.menu_outlined,
                                                    color: isLiked
                                                        ? Colors.redAccent
                                                        : Colors.black45,
                                                    size: 20.0,
                                                  );
                                                },
                                              ),

                                            ],
                                          ))
                                    ],
                                  )
                                 ,
                                ],
                              ),

                            ],
                          ),



                          SizedBox(
                            height: 10.0,
                          ),
                          Divider(
                            // color: thirdColor[100],
                            thickness: 1.0,

                          ),



                          Row(
                            //  mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.subdirectory_arrow_right,
                                //color: onSurface[300]
                              ),
                              Text(
                                ' 엥 저게 1회용 카드에요 ?',
                                // style: body3Style(color: onSurface[900]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Divider(
                            ///color: thirdColor[100],
                            thickness: 1.0,
                          ),
                        ],
                      ),


                    ]),
              ),
            ]),
          ),
        ));
  }
}


