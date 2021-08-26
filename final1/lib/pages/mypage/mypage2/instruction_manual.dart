import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Instruction extends StatefulWidget {
  // Instruction({required this.title, this.url});
  //
  // final String title;
  // final url;

  @override
  _InstructionState createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  late YoutubePlayerController _controller;

  void runYouTubePlayer() {
    _controller = YoutubePlayerController(

        initialVideoId: 'H1atSjmxeAw',
        flags: YoutubePlayerFlags(
          enableCaption: false,
          isLive: false,
          autoPlay: false,
        ));
  }

  @override
  void initState() {
    runYouTubePlayer();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      builder: (context, player) {
        return Scaffold(
            appBar: AppBar(
              title: Text('무물 사용 설명서'),

            ),
            body: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    player,
                    Text(
                        'wegolego Introduction Video'
                    )
                  ],
                )
            )
        );
      },
      player: YoutubePlayer(
        controller: _controller,
      ),
    );
  }
}

//
// class Instruction extends StatefulWidget {
// //  const Instruction({Key key}) : super(key: key);
//
//   @override
//   _InstructionState createState() => _InstructionState();
// }
//
// class _InstructionState extends State<Instruction> {
//   late VideoPlayerController _controller;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
//     _initializeVideoPlayerFuture = _controller.initialize();
//
//     // super.initState();
//     // _controller = VideoPlayerController.network(
//     //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
//     //   ..initialize().then((_) {
//     //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//     //     setState(() {});
//     //   });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: Text(
//           '무물 사용 설명서',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//       ),
//       body: FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return AspectRatio(
//                 aspectRatio:16/9,
//                 //_controller.value.aspectRatio,
//                 child: VideoPlayer(_controller));
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {});
//         },
//         child:Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow
//         )
//       ),
//     );
//   }
//
//   void dispose() {
//     _controller.dispose();
//
//     super.dispose();
//   }
//
// }
