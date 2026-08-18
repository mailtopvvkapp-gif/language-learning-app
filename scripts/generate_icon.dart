import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const size = 1024.0;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, size, size));

  // Background Gradient
  final bgPaint = Paint()
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(size, size),
      [const Color(0xFF2C1654), const Color(0xFF0F0826)],
    );
  canvas.drawRRect(
    RRect.fromRectAndRadius(const Rect.fromLTWH(0, 0, size, size), const Radius.circular(220)),
    bgPaint,
  );

  // Outer Glowing Ring
  final ringPaint = Paint()
    ..color = const Color(0xFFFFD700).withOpacity(0.35)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 18;
  canvas.drawCircle(const Offset(size / 2, size / 2), 430, ringPaint);

  // Open Book Base
  final bookPaint = Paint()..color = const Color(0xFF6C5CE7);
  final bookPath = Path()
    ..moveTo(220, 720)
    ..quadraticBezierTo(512, 650, 804, 720)
    ..lineTo(804, 770)
    ..quadraticBezierTo(512, 700, 220, 770)
    ..close();
  canvas.drawPath(bookPath, bookPaint);

  // Decorative Golden Sparkles
  final starPaint = Paint()..color = const Color(0xFFFFEAA7);
  canvas.drawCircle(const Offset(280, 260), 24, starPaint);
  canvas.drawCircle(const Offset(760, 290), 18, starPaint);

  // Main Emblem Text: 'అ' (Telugu) + 'अ' (Hindi) + 'A' (English)
  const textStyle = TextStyle(
    fontSize: 270,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    shadows: [
      Shadow(color: Color(0xFFFF7675), offset: Offset(6, 6), blurRadius: 18),
      Shadow(color: Colors.black54, offset: Offset(0, 10), blurRadius: 24),
    ],
  );

  final textPainter = TextPainter(
    text: const TextSpan(text: 'అ', style: textStyle),
    textDirection: TextDirection.ltr,
  );
  textPainter.layout();
  textPainter.paint(canvas, Offset((size - textPainter.width) / 2 - 80, (size - textPainter.height) / 2 - 60));

  // Small Hindi 'अ' & English 'A' Floating Badges
  final subPainter = TextPainter(
    text: const TextSpan(
      text: 'अ • A',
      style: TextStyle(
        fontSize: 100,
        fontWeight: FontWeight.bold,
        color: Color(0xFF55EFC4),
        letterSpacing: 4,
      ),
    ),
    textDirection: TextDirection.ltr,
  );
  subPainter.layout();
  subPainter.paint(canvas, Offset((size - subPainter.width) / 2, 770));

  // Render & Save to assets/icon/app_logo.png
  final picture = recorder.endRecording();
  final img = await picture.toImage(size.toInt(), size.toInt());
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  
  final file = File('assets/icon/app_logo.png');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData!.buffer.asUint8List());
  print('App logo generated successfully at assets/icon/app_logo.png');
}
