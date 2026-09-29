// In-Class Activity 06 — Drawing with Flutter
// Student: Swamireddy Ailuri
// Date: September 26, 2026

import 'dart:math' show pi;
import 'package:flutter/material.dart';

void main() => runApp(const SmileyApp());

class SmileyApp extends StatelessWidget {
  const SmileyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smiley Painter Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const DrawingPlayground(),
    );
  }
}

class DrawingPlayground extends StatefulWidget {
  const DrawingPlayground({super.key});

  @override
  State<DrawingPlayground> createState() => _DrawingPlaygroundState();
}

class _DrawingPlaygroundState extends State<DrawingPlayground> {
  double mood = 0.8;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomPainter Smiley Lab'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CustomPaint(
                size: const Size(300, 300),
                painter: SmileyPainter(mood: mood),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Mood: ${mood.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Slider(
                  value: mood,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  label: mood.toStringAsFixed(2),
                  onChanged: (double value) {
                    setState(() {
                      mood = value;
                    });
                  },
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sad'),
                    Text('Neutral'),
                    Text('Happy'),
                  ],
                ),

                const SizedBox(height: 8),

                const Text(
                  'Drag the slider to change the smile',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  SmileyPainter({
    required this.mood,
  });

  final double mood;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.shortestSide * 0.4;

    // Face
    final facePaint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, facePaint);

    // Face outline
    final outlinePaint = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, radius, outlinePaint);

    // Eyes
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final eyeRadius = radius * 0.09;

    final leftEye = Offset(
      center.dx - radius * 0.35,
      center.dy - radius * 0.25,
    );

    final rightEye = Offset(
      center.dx + radius * 0.35,
      center.dy - radius * 0.25,
    );

    canvas.drawCircle(leftEye, eyeRadius, eyePaint);
    canvas.drawCircle(rightEye, eyeRadius, eyePaint);

    
    // Mouth
final mouthPaint = Paint()
  ..color = Colors.black
  ..style = PaintingStyle.stroke
  ..strokeWidth = radius * 0.045
  ..strokeCap = StrokeCap.round;

final mouthWidth = radius * 1.25;
final mouthHeight = radius * 0.75;

final mouthRect = Rect.fromCenter(
  center: Offset(
    center.dx,
    center.dy + radius * 0.18,
  ),
  width: mouthWidth,
  height: mouthHeight,
);

if (mood == 0.5) {
  // Neutral expression
  canvas.drawLine(
    Offset(center.dx - radius * 0.55, center.dy + radius * 0.20),
    Offset(center.dx + radius * 0.55, center.dy + radius * 0.20),
    mouthPaint,
  );
} else if (mood < 0.5) {
  // Sad expression
  canvas.drawArc(
    mouthRect,
    pi * 1.15,
    pi * 0.70,
    false,
    mouthPaint,
  );
} else {
  // Happy expression
  canvas.drawArc(
    mouthRect,
    pi * 0.15,
    pi * 0.70,
    false,
    mouthPaint,
  );
}

    if (mood == 0.5) {
  // Neutral expression
  canvas.drawLine(
    Offset(
      center.dx - radius * 0.55,
      center.dy + radius * 0.20,
    ),
    Offset(
      center.dx + radius * 0.55,
      center.dy + radius * 0.20,
    ),
    mouthPaint,
  );
} else if (mood < 0.5) {
  // Sad expression
  canvas.drawArc(
    mouthRect,
    pi * 1.15,
    pi * 0.70,
    false,
    mouthPaint,
  );
} else {
  // Happy expression
  canvas.drawArc(
    mouthRect,
    pi * 0.15,
    pi * 0.70,
    false,
    mouthPaint,
  );
}

    // Small cheek circles for extra visual polish.
    final cheekPaint = Paint()
      ..color = Colors.orange.withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(
        center.dx - radius * 0.58,
        center.dy + radius * 0.12,
      ),
      radius * 0.08,
      cheekPaint,
    );

    canvas.drawCircle(
      Offset(
        center.dx + radius * 0.58,
        center.dy + radius * 0.12,
      ),
      radius * 0.08,
      cheekPaint,
    );
  }

  @override
  bool shouldRepaint(covariant SmileyPainter oldDelegate) {
    return oldDelegate.mood != mood;
  }
}