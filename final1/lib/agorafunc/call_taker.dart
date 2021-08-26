import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:getx_bottom_navigation_bar/agorafunc/heart.dart';
import 'package:getx_bottom_navigation_bar/agorafunc/thank.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:getx_bottom_navigation_bar/utils/setting.dart';

class CallPage_taker extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? channelName;
  const CallPage_taker({Key? key, this.channelName}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage_taker> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool videoOnOff = false;
  bool _helperIn = false;
  late RtcEngine _engine;
  int? streamId;
  late Offset change;
  bool heart = false;
  late String is_user;
  bool check = true;

  //bool isLoading = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    initialize();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    streamId = await _engine.createDataStream(false, false);
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    //configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);

    await _engine.joinChannel(null, widget.channelName!, null, 0);
    _engine.switchCamera();
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.Communication);
    //만약에 1to1으로 만들려면 LiveBroadcasting이거 대신에 Communication으로 넣으면 일대일이 가능해짐
    //await _engine.setClientRole(ClientRole.Broadcaster);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          _infoStrings.add(info);
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          final info = 'onJoinChannel: $channel, uid: $uid';
          _infoStrings.add(info);
        });
        is_user = uid.toString();
      },
      leaveChannel: (stats) {
        setState(() {
          _infoStrings.add('onLeaveChannel');
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          _infoStrings.add(info);
          _users.add(uid);
        });
        if (check) {
          check = false;
        } else {
          _engine.sendStreamMessage(streamId!, is_user);
        }
      },
      userOffline: (uid, elapsed) {
        setState(() {
          final info = 'userOffline: $uid';
          _infoStrings.add(info);
          _users.remove(uid);
        });
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        setState(() {
          final info = 'firstRemoteVideo: $uid ${width}x $height';
          _infoStrings.add(info);
        });
      },
      streamMessage: (_, __, _coordinates) {
        //final String coordinate = "$message";
        late String first;
        late String second;
        late double d1;
        late double d2;
        if (_coordinates.compareTo('erase') == 0) {
          setState(() {
            drawingPoints = [];
            //drawingPoints.add(drawingPoints[-1]);
          });
        } else if (_coordinates.compareTo('end') == 0) {
          //Navigator.pop(context);
        }
        first = _coordinates.substring(0, _coordinates.indexOf(' '));
        second = _coordinates.substring(
            _coordinates.indexOf(' '), _coordinates.indexOf('a'));
        d1 = double.parse(first);
        d2 = double.parse(second);
        change = Offset(d1 * MediaQuery.of(context).size.width,
            d2 * MediaQuery.of(context).size.height);
        setState(() {
          drawingPoints.add(
            DrawingPoint(
              change,
              Paint()
                ..color = selectedColor
                ..isAntiAlias = true
                ..strokeWidth = strokeWidth
                ..strokeCap = StrokeCap.round,
            ),
          );
        });

        // print(info);
        // _infoStrings.add(info);
      },
      streamMessageError: (_, __, error, ___, ____) {
        final String info = "here is the error $error";
        print(info);
      },
    ));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    //if (widget.role == ClientRole.Broadcaster) {}
    list.add(RtcLocalView.SurfaceView(
      renderMode: VideoRenderMode.FILL,
    ));
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(
          uid: uid,
          renderMode: VideoRenderMode.FILL,
        )));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        //_engine.switchCamera();
        return Container(
          child: Stack(
            children: <Widget>[
              _videoView(views[0]),
              _connecting(),
            ],
          ),
        );
      case 2:
        _helperIn = true;
        return Container(
          child: Column(
            children: <Widget>[
              _expandedVideoRow([views[0]]),
              //_expandedVideoRow([views[1]])
            ],
          ),
        );

      default:
    }
    return Container();
  }

  Widget _connecting() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://i.ibb.co/nsVhXLq/black-background.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        ),
      ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _turnoffcamera() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://i.ibb.co/nsVhXLq/black-background.jpg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.dstATop),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(
                "카메라가 꺼져있습니다",
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              "Helper와 음성으로 도움을 받으세요!",
              style: TextStyle(
                color: Color(0xff979797),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Toolbar layout
  Widget _toolbar() {
    //if (widget.role == ClientRole.Audience) return Container();

    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _helperIn
              ? RawMaterialButton(
                  onPressed: _onSwitchCamera,
                  child: Icon(
                    videoOnOff ? Icons.videocam_off : Icons.videocam,
                    color: videoOnOff ? Colors.white : Colors.blueAccent,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 4.0,
                  fillColor: videoOnOff ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                )
              : RawMaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.videocam,
                    color: Colors.blueAccent,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 4.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
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
          _helperIn
              ? RawMaterialButton(
                  onPressed: _onToggleMute,
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.white : Colors.blueAccent,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 4.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                )
              : RawMaterialButton(
                  onPressed: () {},
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.white : Colors.blueAccent,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 4.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),

          heart
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: MaterialButton(
                    minWidth: 0,
                    onPressed: () async {},
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xffe82b50),
                      size: 35.0,
                    ),
                    padding: const EdgeInsets.all(12.0),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: MaterialButton(
                    minWidth: 0,
                    onPressed: () async {
                      popUp();
                      await _engine.sendStreamMessage(streamId!, "heart");
                    },
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xffe82b50),
                      size: 35.0,
                    ),
                    padding: const EdgeInsets.all(12.0),
                  ),
                ),
          //if (heart == true) heartPop(),
        ],
      ),
    );
  }

  //Love animation
  final _random = math.Random();
  late Timer _timer;
  double height = 0.0;
  int _numConfetti = 10;
  var len;
  bool accepted = false;
  bool stop = false;
  //bool heart = false;

  void popUp() async {
    setState(() {
      heart = true;
    });
    Timer(
        Duration(seconds: 4),
        () => {
              _timer.cancel(),
              setState(() {
                heart = false;
              })
            });
    _timer = Timer.periodic(Duration(milliseconds: 125), (Timer t) {
      setState(() {
        height += _random.nextInt(20);
      });
    });
  }

  Widget heartPop() {
    final size = MediaQuery.of(context).size;
    final confetti = <Widget>[];
    for (var i = 0; i < _numConfetti; i++) {
      final height = _random.nextInt(size.height.floor());
      //final width = 0;
      confetti.add(HeartAnim(
        height % 300.0,
        //width.toDouble(),
        1,
      ));
    }

    return Container(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            //height: 400,
            width: (MediaQuery.of(context).size.width) / 2,
            child: Stack(
              children: confetti,
            ),
          ),
        ),
      ),
    );
  }

  /// Info panel to show logs
  Widget _panel() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ListView.builder(
            reverse: true,
            itemCount: _infoStrings.length,
            itemBuilder: (BuildContext context, int index) {
              if (_infoStrings.isEmpty) {
                return Text(
                    "null"); // return type can't be null, a widget was required
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _infoStrings[index],
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCallEnd(BuildContext context) {
    _engine.sendStreamMessage(streamId!, "end");

    Get.off(
      Thank(),
      transition: Transition.native,
    );
    //Get.defaultDialog();
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.sendStreamMessage(streamId!, "onoffVideo");
    setState(() {
      videoOnOff = !videoOnOff;
    });
  }

  //drawing
  Color selectedColor = Colors.purple;
  double strokeWidth = 5;
  List<DrawingPoint> drawingPoints = [];
  late String getdetails;
  late double nomalizationDx;
  late double nomalizationDy;

  @override
  Widget drawing(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          //taker는 그리는거 안하게 함
          GestureDetector(
            onPanStart: (details) {
              setState(() {
                drawingPoints = [];
                drawingPoints.add(drawingPoints[-1]);
                // drawingPoints.add(
                //   DrawingPoint(
                //     details.localPosition,
                //     Paint()
                //       ..color = selectedColor
                //       ..isAntiAlias = true
                //       ..strokeWidth = strokeWidth
                //       ..strokeCap = StrokeCap.round,
                //   ),
                // );
              });
              // getdetails = "dfg";
              // _engine.sendStreamMessage(streamId!, getdetails);
            },
            onPanUpdate: (details) {
              // setState(() {
              //   drawingPoints.add(
              //     DrawingPoint(
              //       details.localPosition,
              //       Paint()
              //         ..color = selectedColor
              //         ..isAntiAlias = true
              //         ..strokeWidth = strokeWidth
              //         ..strokeCap = StrokeCap.round,
              //     ),
              //   );
              // });
              // // nomalizationDx =
              // //     details.localPosition.dx / MediaQuery.of(context).size.width;
              // // nomalizationDy =
              // //     details.localPosition.dy / MediaQuery.of(context).size.height;
              // // getdetails = nomalizationDx.toString() +
              // //     " " +
              // //     nomalizationDy.toString() +
              // //     "a";

              // // _engine.sendStreamMessage(streamId!, getdetails);
            },
            onPanEnd: (details) {
              setState(() {
                drawingPoints = [];
                drawingPoints.add(drawingPoints[-1]);
              });
            },
            child: CustomPaint(
              painter: _DrawingPainter(drawingPoints),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 30,
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () => setState(() => drawingPoints = []),
                  icon: Icon(Icons.clear),
                  label: Text("Clear Board"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: videoOnOff
            ? Center(
                child: Stack(
                  children: <Widget>[
                    _turnoffcamera(),
                    _panel(),
                    _toolbar(),
                  ],
                ),
              )
            : Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      _viewRows(),
                      if (heart == true) heartPop(),
                      _panel(),
                      drawing(context),
                      _toolbar(),
                    ],
                  ),
                ),
              ));
  }
}

class _DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;

  _DrawingPainter(this.drawingPoints);

  List<Offset> offsetsList = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < drawingPoints.length; i++) {
      if (drawingPoints[i] != null && drawingPoints[i + 1] != null) {
        canvas.drawLine(drawingPoints[i].offset, drawingPoints[i + 1].offset,
            drawingPoints[i].paint);
      } else if (drawingPoints[i] != null && drawingPoints[i + 1] == null) {
        offsetsList.clear();
        offsetsList.add(drawingPoints[i].offset);

        canvas.drawPoints(
            PointMode.points, offsetsList, drawingPoints[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoint {
  Offset offset;
  Paint paint;

  DrawingPoint(this.offset, this.paint);
}
