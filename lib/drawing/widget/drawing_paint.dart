import 'dart:ui';

import 'package:drawing_app/drawing/model/text_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double thickness;
  final List<TextEntry> textEntries;

  DrawingPainter(
    this.points,
    this.color,
    this.thickness, {
    required this.textEntries,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(PointMode.points, [points[i]!], paint);
      }
    }

    for (var textEntry in textEntries) {
      canvas.save();
      canvas.translate(textEntry.position.dx, textEntry.position.dy);
      canvas.rotate(textEntry.rotation);
      final textStyle = GoogleFonts.getFont(
        textEntry.fontFamily,
        color: textEntry.color,
        fontSize: textEntry.fontSize,
      );
      final textSpan = TextSpan(
        text: textEntry.text,
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
