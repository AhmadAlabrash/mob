import 'package:flutter/material.dart';

class WalletGridBoxPainter extends CustomPainter {
  final Color color;
  WalletGridBoxPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9991375, size.height * 0.6356139);
    path_0.cubicTo(
        size.width * 0.9966125,
        size.height * 0.6947931,
        size.width * 0.9725750,
        size.height * 0.7394403,
        size.width * 0.9451625,
        size.height * 0.7280306);
    path_0.cubicTo(
        size.width * 0.7910250,
        size.height * 0.6638833,
        size.width * 0.6990563,
        size.height * 0.4608083,
        size.width * 0.6815188,
        size.height * 0.1096333);
    path_0.cubicTo(
        size.width * 0.6787125,
        size.height * 0.05334486,
        size.width * 0.6981000,
        size.height * 0.006381347,
        size.width * 0.7232938,
        0);
    path_0.lineTo(size.width * 0.9491375, 0);
    path_0.cubicTo(
        size.width * 0.9767500,
        0,
        size.width * 0.9991375,
        size.height * 0.04974611,
        size.width * 0.9991375,
        size.height * 0.1111111);
    path_0.lineTo(size.width * 0.9991375, size.height * 0.6356139);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
