import 'package:drawing_app/drawing/view_model/drawing_provider.dart';
import 'package:drawing_app/drawing/widget/drawing_paint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawingCanvas extends StatelessWidget {
  const DrawingCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawingProvider>(
      builder: (context, drawingProvider, child) {
        return GestureDetector(
          onPanUpdate: (details) {
            Offset localPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(details.globalPosition);
            drawingProvider.addPoint(localPosition);
          },
          onPanEnd: (details) {
            drawingProvider.addNullPoint();
          },
          child: CustomPaint(
            size: Size.infinite,
            painter: DrawingPainter(
              drawingProvider.points,
              drawingProvider.currentColor,
              drawingProvider.currentThickness,
              textEntries: drawingProvider.textEntries,
            ),
          ),
        );
      },
    );
  }
}
