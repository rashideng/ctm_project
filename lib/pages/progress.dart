import 'package:flutter/material.dart';

void main() {
  runApp(Indicator());
}

class Indicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                      colors: [Colors.blue, Colors.transparent],
                      startAngle: 0.0,
                      endAngle: 3.14 * 2,
                      center: Alignment.center,
                    ).createShader(rect);
                  },
                  child: Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
