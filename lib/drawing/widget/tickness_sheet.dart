import 'package:drawing_app/drawing/view_model/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showThicknessSlider(BuildContext context) {
  double currentThickness =
      Provider.of<DrawingProvider>(context, listen: false).currentThickness;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Select thickness',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Slider(
              value: currentThickness,
              min: 1.0,
              max: 20.0,
              divisions: 19,
              label: currentThickness.toString(),
              onChanged: (double value) {
                Provider.of<DrawingProvider>(context, listen: false)
                    .updateThickness(value);
              },
            ),
          ],
        ),
      );
    },
  );
}
