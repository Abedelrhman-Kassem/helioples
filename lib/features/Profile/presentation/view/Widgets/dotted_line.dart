import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final double dotWidth;
  final double spacing;
  final Color color;
  const DottedLine({
    Key? key,
    this.height = 1.0,
    this.dotWidth = 5.0,
    this.spacing = 3.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _DottedLinePainter(
          height: height,
          dotWidth: dotWidth,
          spacing: spacing,
          color: color,
        ),
        size: Size(double.infinity, height));
  }
}

class _DottedLinePainter extends CustomPainter {
  final double height;
  final double dotWidth;
  final double spacing;
  final Color color;

  _DottedLinePainter({
    required this.height,
    required this.dotWidth,
    required this.spacing,
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;
    double startx = 0;
    while (startx < size.width) {
      canvas.drawLine(Offset(startx, 0), Offset(startx + dotWidth, 0), paint);
      startx += dotWidth + spacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
