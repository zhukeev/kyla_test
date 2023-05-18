import 'dart:math';

import 'package:flutter/material.dart';

class BottomAnimationClipper extends CustomClipper<Path> {
  final double topCircleSize;
  final double curveHeight;

  const BottomAnimationClipper({
    required this.topCircleSize,
    required this.curveHeight,
  });
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;

    final halfW = w * 0.5;

    final path = Path();

    final topLeft = Offset(halfW - topCircleSize + 8, curveHeight + 8);
    final topRight = Offset(halfW + topCircleSize - 8, curveHeight + 8);
    final midLine = Offset(halfW, curveHeight + 8);

    // Width of the curve
    // Gets thinner as it goes to [curveHeight]
    final midWidth = (h - curveHeight) * .2;

    path.moveTo(0, size.height);
    path.quadraticBezierTo(halfW + midWidth, h, topLeft.dx, topLeft.dy);
    path.lineTo(midLine.dx, midLine.dy);
    path.lineTo(halfW, h);
    path.moveTo(topLeft.dx, topLeft.dy);

    path.moveTo(w, h);
    path.quadraticBezierTo(halfW - midWidth - 1, h, topRight.dx, topRight.dy);
    path.lineTo(midLine.dx, midLine.dy);
    path.lineTo(halfW, h);
    path.moveTo(topLeft.dx, topLeft.dy);

    final mid = Offset((topLeft.dx + topRight.dx) / 2, (topLeft.dy + topRight.dy) / 2);

    path.addArc(
      Rect.fromCircle(
        center: mid,
        radius: topCircleSize - 8,
      ),
      pi,
      pi,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
