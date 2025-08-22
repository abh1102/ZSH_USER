import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';
import 'dart:math' as math;

class CustomCircularProgressBar extends StatelessWidget {
  final double value;

  CustomCircularProgressBar({required this.value});

  @override
  Widget build(BuildContext context) {
    double percentage = value / 10.0; // Convert the value to a percentage
     String formattedValue = value.toStringAsFixed(1);

    return SizedBox(
      width: 76,
      height: 76,
      child: CustomPaint(
        painter: CircularProgressBarPainter(percentage: percentage),
        child: Center(
          child: Text(
            '$formattedValue/10',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}



class CircularProgressBarPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth = 10.0;

  CircularProgressBarPainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - strokeWidth / 2;

    final Paint completedPaint = Paint()
      ..color = AppColors.primaryGreen
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint incompletePaint = Paint()
      ..color = Color(0xffEFEFEF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      completedPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + sweepAngle,
      2 * math.pi - sweepAngle,
      false,
      incompletePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
