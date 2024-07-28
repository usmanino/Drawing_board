import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TextEntry {
  Offset position;
  String text;
  Color color;
  double fontSize;
  String fontFamily;
  double rotation; // Rotation angle in radians

  TextEntry({
    required this.position,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontFamily,
    this.rotation = 0.0,
  });

  TextEntry copyWith({
    Offset? position,
    String? text,
    Color? color,
    double? fontSize,
    String? fontFamily,
    double? rotation,
  }) =>
      TextEntry(
        position: position ?? this.position,
        text: text ?? this.text,
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontFamily: fontFamily ?? this.fontFamily,
        rotation: rotation ?? this.rotation,
      );
}
