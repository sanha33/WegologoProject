import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';

import '../utils/settings.dart';

class CallPage_helper extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? channelName;

  /// non-modifiable client role of the page
  //final ClientRole? role;

  /// Creates a call page with given channel name.
  const CallPage_helper({Key? key, this.channelName}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage_helper> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  bool videoOnOff = false;
  late RtcEngine _engine;
  int? streamId;
  late Offset change;

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
    streamId = await _engine.createDataStream(true, true);
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    //configuration.dimensions = VideoDimensions(1920, 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(null, widget.channelName!, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(APP_ID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    //만약에 1to1으로 만들려면 LiveBroadcasting이거 대신에 Communication으로 넣으면 일대일이 가능해짐
    await _engine.setClientRole(ClientRole.Broadcaster);
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
      streamMessage: (_, __, coordinates) {
        if (coordinates.compareTo('end') == 0) {
          Navigator.pop(context);
        } else if (coordinates.compareTo('onoffVideo') == 0) {
          setState(() {
            videoOnOff = !videoOnOff;
          });
        }
        //final String coordinate = "$message";
        // late String first;
        // late String second;
        // late double d1;
        // late double d2;
        // if (coordinates.compareTo('erase') == 0) {
        //   setState(() {
        //     drawingPoints = [];
        //     drawingPoints.add(drawingPoints[-1]);
        //   });
        // } else {
        //   first = coordinates.substring(0, coordinates.indexOf(' '));
        //   second = coordinates.substring(
        //       coordinates.indexOf(' '), coordinates.indexOf('a'));
        //   d1 = double.parse(first);
        //   d2 = double.parse(second);
        //   change = Offset(d1 * MediaQuery.of(context).size.width,
        //       d2 * MediaQuery.of(context).size.height);
        //   setState(() {
        //     drawingPoints.add(
        //       DrawingPoint(
        //         change,
        //         Paint()
        //           ..color = selectedColor
        //           ..isAntiAlias = true
        //           ..strokeWidth = strokeWidth
        //           ..strokeCap = StrokeCap.round,
        //       ),
        //     );
        //   });
        // }

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
    list.add(RtcLocalView.SurfaceView(renderMode: VideoRenderMode.FILL));
    _users.forEach((int uid) => list.add(
        RtcRemoteView.SurfaceView(uid: uid, renderMode: VideoRenderMode.FILL)));
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
        return Container(
            child: Column(
              children: <Widget>[_videoView(views[0])],
            ));
      case 2:
        CircularProgressIndicator();
        return Container(
            child: Column(
              children: <Widget>[
                _expandedVideoRow([views[1]]),
              ],
            ));
    // case 3:
    //   return Container(
    //       child: Column(
    //     children: <Widget>[
    //       _expandedVideoRow(views.sublist(0, 2)),
    //       _expandedVideoRow(views.sublist(2, 3))
    //     ],
    //   ));
    // case 4:
    //   return Container(
    //       child: Column(
    //     children: <Widget>[
    //       _expandedVideoRow(views.sublist(0, 2)),
    //       _expandedVideoRow(views.sublist(2, 4))
    //     ],
    //   ));
      default:
    }
    return Container();
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
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
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
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          // RawMaterialButton(
          //   onPressed: _onSwitchCamera,
          //   child: Icon(
          //     Icons.switch_camera,
          //     color: Colors.blueAccent,
          //     size: 20.0,
          //   ),
          //   shape: CircleBorder(),
          //   elevation: 2.0,
          //   fillColor: Colors.white,
          //   padding: const EdgeInsets.all(12.0),
          // )
        ],
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
    Navigator.pop(context);
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    // _engine.switchCamera();
    // _engine.sendStreamMessage(streamId!, "메세지 보낸 건 이거다");
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
        child: Text(
          "음성으로 소통하세요",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  //drawing
  Color selectedColor = Colors.purple;
  double strokeWidth = 5;
  List<DrawingPoint> drawingPoints = [];
  List<Color> colors = [
    Colors.pink,
    Colors.red,
    Colors.black,
    Colors.yellow,
    Colors.amberAccent,
    Colors.purple,
    Colors.green,
  ];
  late String getdetails;
  late double nomalizationDx;
  late double nomalizationDy;

  @override
  Widget drawing(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          GestureDetector(
            onPanStart: (details) {
              getdetails = "erase";
              print("처음 보냄!");
              print("$getdetails");
              _engine.sendStreamMessage(streamId!, getdetails);
              setState(() {
                drawingPoints = [];
                drawingPoints.add(drawingPoints[-1]);
                drawingPoints.add(
                  DrawingPoint(
                    details.localPosition,
                    Paint()
                      ..color = selectedColor
                      ..isAntiAlias = true
                      ..strokeWidth = strokeWidth
                      ..strokeCap = StrokeCap.round,
                  ),
                );
              });
            },
            onPanUpdate: (details) {
              setState(() {
                drawingPoints.add(
                  DrawingPoint(
                    details.localPosition,
                    Paint()
                      ..color = selectedColor
                      ..isAntiAlias = true
                      ..strokeWidth = strokeWidth
                      ..strokeCap = StrokeCap.round,
                  ),
                );
              });
              nomalizationDx =
                  details.localPosition.dx / MediaQuery.of(context).size.width;
              nomalizationDy =
                  details.localPosition.dy / MediaQuery.of(context).size.height;
              getdetails = nomalizationDx.toString() +
                  " " +
                  nomalizationDy.toString() +
                  "a";
              print("drawing 뭔가 보내고 있는 중");
              _engine.sendStreamMessage(streamId!, getdetails);
            },
            onPanEnd: (details) {
              // getdetails = "erase";
              // print("마지막 보냄!");
              // print("$getdetails");
              //_engine.sendStreamMessage(streamId!, getdetails);
              setState(() {
                // drawingPoints = [];
                // drawingPoints.add(drawingPoints[-1]);
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
                //크기조절은 불필요
                // Slider(
                //요  min: 0,
                //   max: 40,
                //   value: strokeWidth,
                //   onChanged: (val) => setState(() => strokeWidth = val),
                // ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() => drawingPoints = []);
                    _engine.sendStreamMessage(streamId!, "erase");
                  },
                  icon: Icon(Icons.clear),
                  label: Text("Clear Board"),
                )
              ],
            ),
          ),
        ],
      ),
      //bottomNavigationBar: BottomAppBar(
      //원래는 여기 들어가야 합니다.
      // child: Container(
      //   color: Colors.grey[200],
      //   padding: EdgeInsets.all(10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: List.generate(
      //       colors.length,
      //       (index) => _buildColorChose(colors[index]),
      //     ),
      //   ),
      // ),
      //),
    );
  }

  Widget _buildColorChose(Color color) {
    bool isSelected = selectedColor == color;
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        height: isSelected ? 47 : 40,
        width: isSelected ? 47 : 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Agora Flutter QuickStart'),
        ),
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
                //CircularProgressIndicator(),
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
