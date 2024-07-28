// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:drawing_app/drawing/view_model/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DrawingProvider Tests', () {
    late DrawingProvider drawingProvider;

    setUp(() {
      drawingProvider = DrawingProvider();
    });

    test('Initial points list is empty', () {
      expect(drawingProvider.points, []);
    });

    test('Add point to points list', () {
      drawingProvider.addPoint(Offset(10, 10));
      expect(drawingProvider.points.length, 1);
    });

    test('Clear canvas should empty points list', () {
      drawingProvider.addPoint(Offset(10, 10));
      drawingProvider.clearCanvas();
      expect(drawingProvider.points, []);
    });

    test('Update color should change current color', () {
      drawingProvider.updateColor(Colors.red);
      expect(drawingProvider.currentColor, Colors.red);
    });

    test('Update thickness should change current thickness', () {
      drawingProvider.updateThickness(5.0);
      expect(drawingProvider.currentThickness, 5.0);
    });

    test('Create new slide', () {
      // drawingProvider.createNewSlide();
      expect(drawingProvider.slides.length, 2);
      expect(drawingProvider.currentSlideIndex, 1);
    });

    test('Switch slide', () {
      // drawingProvider.createNewSlide();
      // drawingProvider.switchSlide(0);
      // expect(drawingProvider.currentSlideIndex, 0);
    });

    // Add more tests as needed
  });
}
