import 'package:flutter/cupertino.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = RadialGradient(
      colors: [
        Color(0xFFFF8A80),
        Color(0xFFFF8A80),
      ],
      center: Alignment(0.5, 0.5),
      radius: 1.5,
    );

    Paint paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 3, size.width, size.height),
      )
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.quadraticBezierTo(
      size.width * 3,
      size.height * 3,
      size.width * 3,
      size.height * 3,
    );
    path.moveTo(0, size.height);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}