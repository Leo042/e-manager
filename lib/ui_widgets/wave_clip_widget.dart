import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class WaveClip extends StatelessWidget {
  Widget _clipPath(
      double size, CustomClipper<Path> clipper, Gradient gradient) {
    return ClipPath(
      clipper: clipper,
      child: Container(
        child: Column(),
        width: double.infinity,
        height: size,
        decoration: BoxDecoration(gradient: gradient),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _clipPath(
          350,
          WaveClipperOne(flip: true),
          LinearGradient(colors: [Colors.grey, Colors.blueGrey]
            // [Color(0x22ff3a5a), Color(0x22fe494d)]
          ),
        ),
        _clipPath(
          400,
          WaveClipperTwo(flip: true),
          LinearGradient(colors: [Colors.lightBlueAccent, Colors.lightBlue]
            // [Color(0x44ff3a5a), Color(0x44fe494d)]
          ),
        ),
        ClipPath(
          clipper: WaveClipperOne(),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Icon(
                  Icons.add_business,
                  color: Colors.white,
                  size: 60,
                ),
                SizedBox(height: 20),
                Text(
                  'ovSpot',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ],
            ),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              gradient:
              LinearGradient(colors: [Colors.blueAccent, Colors.blue]),
              // Color(0xffff3a5a), Color(0xfffe494d)])
            ),
          ),
        )
      ],
    );
  }
}
