import 'dart:ui' as ui;
import 'package:drawing_app/drawing/model/text_entry_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:flutter/rendering.dart';

class DrawingProvider with ChangeNotifier {
  List<List<Offset?>> slides = [
    []
  ]; // List of slides with each slide containing points
  int currentSlideIndex = 0;
  Color currentColor = Colors.black;
  double currentThickness = 4.0;
  final List<Offset?> _redoStack = [];
  List<Offset?> get points => slides[currentSlideIndex];
  Color backgroundColor = Colors.white;
  List<TextEntry> textEntries = [];

  void addPoint(Offset point) {
    slides[currentSlideIndex].add(point);
    notifyListeners();
  }

  void addNullPoint() {
    slides[currentSlideIndex].add(null);
    notifyListeners();
  }

  void updateColor(Color color) {
    currentColor = color;
    notifyListeners();
  }

  void updateThickness(double thickness) {
    currentThickness = thickness;
    notifyListeners();
  }

  void clearCanvas() {
    slides[currentSlideIndex] = [];
    notifyListeners();
  }

  void undo() {
    if (slides[currentSlideIndex].isNotEmpty) {
      _redoStack.add(slides[currentSlideIndex].removeLast());
      notifyListeners();
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      slides[currentSlideIndex].add(_redoStack.removeLast());
      notifyListeners();
    }
  }

  void createNewSlide() {
    slides.add([]);
    currentSlideIndex = slides.length - 1;
    _redoStack.clear(); // Clear redo stack on new action
    notifyListeners();
  }

  void switchSlide(int index) {
    if (index >= 0 && index < slides.length) {
      currentSlideIndex = index;
      _redoStack.clear(); // Clear redo stack on new action
      notifyListeners();
    }
  }

  void addTextEntry(TextEntry textEntry) {
    textEntries.add(textEntry);
    notifyListeners();
  }

  void updateTextPosition(int index, Offset newPosition) {
    if (index >= 0 && index < textEntries.length) {
      textEntries[index].position = newPosition;
      notifyListeners();
    }
  }

   void updateTextEntry(int index, TextEntry updatedEntry) {
    if (index >= 0 && index < textEntries.length) {
      textEntries[index] = updatedEntry;
      notifyListeners();
    }
  }


  void updateTextRotation(int index, double newRotation) {
    if (index >= 0 && index < textEntries.length) {
      textEntries[index].rotation = newRotation;
      notifyListeners();
    }
  }

  Future<void> saveDrawing(GlobalKey globalKey) async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final blob = html.Blob([pngBytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "drawing.png")
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
