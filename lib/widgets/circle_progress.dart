import 'dart:math';
import 'package:ca6/res/styles.dart';
import 'package:flutter/material.dart';

class CircleProgress extends CustomPainter {
  double value;
  bool isVal;

  CircleProgress(this.value, this.isVal);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double maximumValue = 20.0;
     // Max value for Volume (L)

    Paint outerCircle = Paint()
      ..strokeWidth = 14
      ..color = CustomColors.whiteCreamOri
      ..style = PaintingStyle.stroke;

    Paint volArc = Paint()
      ..strokeWidth = 14
      ..color = CustomColors.colorAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;


    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 14;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (value / maximumValue);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, volArc);
  }
}