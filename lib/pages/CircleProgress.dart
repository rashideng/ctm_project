import 'package:flutter/material.dart';
import 'dart:math';

class CircleProgress extends CustomPainter {
  double value;
  bool isTemp;
  CircleProgress(this.value, this.isTemp);

  @override
  void paint(Canvas canvas, Size size) {
    int maximumValue = isTemp ? 50 : 100; //Temperature maximum value is 100

    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Paint tempArc = Paint()
      ..strokeWidth = 10
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);
    double angle = 2 * pi * (value / maximumValue);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, tempArc); //change if got wrong
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
