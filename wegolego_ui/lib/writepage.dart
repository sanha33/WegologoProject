import 'package:flutter/material.dart';

class WritePage extends StatefulWidget {
 // const WritePage({Key key}) : super(key: key);

  @override
  _WritePageState createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: writeboard(),
      appBar: new AppBar(
        leading: new Text('취소'),
        title: Text(
          '글쓰기',
          style: TextStyle(color: Colors.black),
        ),
        actions:[new Text('완')],
        backgroundColor: Colors.white,
      ),
    );
  }
}

Widget writeboard(){
  return
    Container(
      margin: EdgeInsets.all(15.0),
    //  width: 300.0,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
decoration: InputDecoration(
  //border: OutlineInputBorder()
  hintText: '글의 제목을 입력해주세요'
),
            ),
            SizedBox(height: 15.0,),
            TextField(
              decoration: InputDecoration(
                hintText: '궁금한 것을 질문해보세요 !'
              //    border: OutlineInputBorder()
              ),
            ),
          ],
        ),
      ),
    );
}
