import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const double size = 1024.0;
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, size, size));

  // 1. Premium Deep Purple Gradient Background
  final bgPaint = Paint()
    ..shader = ui.Gradient.linear(
      const Offset(0, 0),
      const Offset(size, size),
      [const Color(0xFF3B1E6D), const Color(0xFF16082F)],
    );
  canvas.drawRRect(
    RRect.fromRectAndRadius(const Rect.fromLTWH(0, 0, size, size), const Radius.circular(220)),
    bgPaint,
  );

  // 2. Golden Glowing Border Ring
  final borderPaint = Paint()
    ..color = const Color(0xFFFFD166).withOpacity(0.4)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 20;
  canvas.drawCircle(const Offset(size / 2, size / 2), 440, borderPaint);

  // 3. Open Book / Learning Slate Platform Base
  final basePaint = Paint()..color = const Color(0xFF6C5CE7);
  final basePath = Path()
    ..moveTo(200, 720)
    ..quadraticBezierTo(512, 640, 824, 720)
    ..lineTo(824, 780)
    ..quadraticBezierTo(512, 700, 200, 780)
    ..close();
  canvas.drawPath(basePath, basePaint);

  // 4. Primary Hero Character 'అ' (Telugu)
  const heroStyle = TextStyle(
    fontSize: 320,
    fontWeight: FontWeight.w900,
    color: Colors.white,
    shadows: [
      Shadow(color: Color(0xFFFF7675), offset: Offset(6, 6), blurRadius: 16),
      Shadow(color: Colors.black87, offset: Offset(0, 10), blurRadius: 28),
    ],
  );
  final heroPainter = TextPainter(
    text: const TextSpan(text: 'అ', style: heroStyle),
    textDirection: TextDirection.ltr,
  );
  heroPainter.layout();
  heroPainter.paint(
    canvas,
    Offset((size - heroPainter.width) / 2 - 40, (size - heroPainter.height) / 2 - 70),
  );

  // 5. Secondary Accents 'अ' (Hindi) & 'A' (English)
  const subStyle = TextStyle(
    fontSize: 100,
    fontWeight: FontWeight.w800,
    color: Color(0xFF55EFC4),
    letterSpacing: 8,
    shadows: [
      Shadow(color: Colors.black54, offset: Offset(0, 4), blurRadius: 10),
    ],
  );
  final subPainter = TextPainter(
    text: const TextSpan(text: 'अ • A', style: subStyle),
    textDirection: TextDirection.ltr,
  );
  subPainter.layout();
  subPainter.paint(
    canvas,
    Offset((size - subPainter.width) / 2, 780),
  );

  // 6. Floating Sparkles
  final starPaint = Paint()..color = const Color(0xFFFFEAA7);
  canvas.drawCircle(const Offset(270, 260), 22, starPaint);
  canvas.drawCircle(const Offset(780, 310), 16, starPaint);
  canvas.drawCircle(const Offset(820, 230), 10, starPaint);

  // Render Image & Write PNG File
  final picture = recorder.endRecording();
  final img = await picture.toImage(size.toInt(), size.toInt());
  final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

  final file = File('assets/icon/app_logo.png');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData!.buffer.asUint8List());
}
