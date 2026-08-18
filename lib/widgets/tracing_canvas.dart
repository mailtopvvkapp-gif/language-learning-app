import 'package:flutter/material.dart';

class TracingCanvas extends StatefulWidget {
  final String charToTrace;
  const TracingCanvas({Key? key, required this.charToTrace}) : super(key: key);

  @override
  State<TracingCanvas> createState() => _TracingCanvasState();
}

class _TracingCanvasState extends State<TracingCanvas> {
  List<Offset?> points = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          widget.charToTrace,
          style: TextStyle(
            fontSize: 180,
            color: Colors.white.withOpacity(0.18),
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox renderBox = context.findRenderObject() as RenderBox;
              points.add(renderBox.globalToLocal(details.globalPosition));
            });
          },
          onPanEnd: (details) => points.add(null),
          child: CustomPaint(
            painter: StrokePainter(points: points),
            size: Size.infinite,
          ),
        ),
      ],
    );
  }
}

class StrokePainter extends CustomPainter {
  final List<Offset?> points;
  StrokePainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFFFF7675)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(StrokePainter oldDelegate) => true;
}
