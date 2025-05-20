import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularActivityIndicator extends StatelessWidget {
  final int percentage;
  final int currentActivity;
  final int totalActivity;

  const CircularActivityIndicator({
    super.key,
    required this.percentage,
    required this.currentActivity,
    required this.totalActivity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100.0, // Adjust size as needed
              height: 100.0,
              child: CustomPaint(
                painter: CircularProgressPainter(
                  percentage: percentage,
                  trackColor: Colors.grey.shade800,
                  progressColor: Colors.red.shade600,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$percentage',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Percent',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 24.0), // Spacing between circle and text
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Activity',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white70,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: '$currentActivity',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const TextSpan(
                      text: ' / ',
                      style: TextStyle(color: Colors.white70),
                    ),
                    TextSpan(
                      text: '$totalActivity',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final int percentage;
  final Color trackColor;
  final Color progressColor;

  CircularProgressPainter({
    required this.percentage,
    required this.trackColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    const startAngle = -math.pi / 2; // Start from the top

    final trackPaint = Paint()
      ..strokeWidth = 8.0 // Adjust thickness as needed
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..strokeWidth = 8.0
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final sweepAngle = 2 * math.pi * (percentage / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor;
  }
}
