import 'dart:math' as math;
import 'package:flutter/material.dart';

class HeartAnim extends StatelessWidget {
  final double top;
  //final double left;
  final double opacity;

  HeartAnim(
    this.top,
    //this.left,
    this.opacity,
  );

  //

  Widget build(BuildContext context) {
    final random = math.Random();
    final confetti = Container(
      child: Opacity(
          opacity: 0.95,
          child: Icon(
            Icons.favorite,
            color: Color(0xffe82b50),
            size: (30 + random.nextInt(30)).toDouble(),
          )),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
    return Positioned(
      bottom: top,
      //right: left,
      child: confetti,
    );
  }
}
