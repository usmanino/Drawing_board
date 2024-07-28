import 'package:drawing_app/drawing/view_model/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

void showColorPicker(BuildContext context) {
  Color pickerColor =
      Provider.of<DrawingProvider>(context, listen: false).currentColor;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Pick a color',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                Provider.of<DrawingProvider>(context, listen: false)
                    .updateColor(color);
              },
            ),
          ],
        ),
      );
    },
  );
}
