import 'package:flutter/material.dart';

class WalletGridIconBoxPainter extends CustomPainter {
  final Color color;
  WalletGridIconBoxPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6100026, 0);
    path_0.lineTo(size.width * 0.9487179, 0);
    path_0.cubicTo(size.width * 0.9770385, 0, size.width,
        size.height * 0.02266911, size.width, size.height * 0.05063291);
    path_0.lineTo(size.width, size.height * 0.4285506);
    path_0.cubicTo(
        size.width * 0.9696474,
        size.height * 0.4379633,
        size.width * 0.9373462,
        size.height * 0.4430380,
        size.width * 0.9038462,
        size.height * 0.4430380);
    path_0.cubicTo(
        size.width * 0.7268333,
        size.height * 0.4430380,
        size.width * 0.5833333,
        size.height * 0.3013557,
        size.width * 0.5833333,
        size.height * 0.1265823);
    path_0.cubicTo(
        size.width * 0.5833333,
        size.height * 0.08157595,
        size.width * 0.5928494,
        size.height * 0.03876342,
        size.width * 0.6100026,
        0);
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
