import 'package:flutter/material.dart';

class ArrowBorderedCard extends StatelessWidget {
  final Widget body;
  const ArrowBorderedCard({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ArrowBorderPainter(),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
    );
  }
}

class ArrowBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double cornerSize = 10.0;
    const double offset = 10.0;

    final Paint cornerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Paint linePaint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Top Left Arrow
    path.moveTo(cornerSize, 0);
    path.lineTo(0, 0);
    path.lineTo(0, offset);
    path.lineTo(0, cornerSize);
    canvas.drawPath(path, cornerPaint);

    // Top Line
    path.reset();
    path.moveTo(cornerSize + offset, 0);
    path.lineTo(size.width - cornerSize - offset, 0);
    canvas.drawPath(path, linePaint);

    // Top Right Arrow
    path.reset();
    path.moveTo(size.width - cornerSize, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, offset);
    path.lineTo(size.width, cornerSize);
    canvas.drawPath(path, cornerPaint);

    // Right Line
    path.reset();
    path.moveTo(size.width, cornerSize + offset);
    path.lineTo(size.width, size.height - cornerSize - offset);
    canvas.drawPath(path, linePaint);

    // Bottom Right Arrow
    path.reset();
    path.moveTo(size.width, size.height - cornerSize);
    path.lineTo(size.width, size.height - offset);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - cornerSize, size.height);
    canvas.drawPath(path, cornerPaint);

    // Bottom Line
    path.reset();
    path.moveTo(size.width - cornerSize - offset, size.height);
    path.lineTo(cornerSize + offset, size.height);
    canvas.drawPath(path, linePaint);

    // Bottom Left Arrow
    path.reset();
    path.moveTo(cornerSize, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height - offset);
    path.lineTo(0, size.height - cornerSize);
    canvas.drawPath(path, cornerPaint);

    // Left Line
    path.reset();
    path.moveTo(0, size.height - cornerSize - offset);
    path.lineTo(0, cornerSize + offset);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
