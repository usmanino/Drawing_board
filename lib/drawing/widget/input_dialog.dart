import 'package:drawing_app/drawing/model/text_entry_model.dart';
import 'package:drawing_app/drawing/view_model/drawing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

final List<String> fontOptions = [
  'Roboto',
  'Open Sans',
  'Lobster',
  'Pacifico',
  'Lato',
  // Add more fonts as needed
];
void showTextInputDialog(BuildContext context) {
  TextEditingController textController = TextEditingController();
  String selectedFont = fontOptions[0];

  Color selectedColor = Colors.black;
  double selectedFontSize = 20.0;
  // String selectedFontFamily = 'Roboto';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Text'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(labelText: 'Text'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Color:'),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Choose Color'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: selectedColor,
                            onColorChanged: (color) {
                              selectedColor = color;
                            },
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Got it'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    color: selectedColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Font Size:'),
                const SizedBox(width: 10),
                Slider(
                  value: selectedFontSize,
                  min: 10.0,
                  max: 40.0,
                  onChanged: (value) {
                    selectedFontSize = value;
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Font Family:'),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedFont,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedFont = newValue;
                    }
                  },
                  items:
                      fontOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () {
              if (textController.text.isNotEmpty) {
                Offset position = const Offset(100, 100);
                final textEntry = TextEntry(
                  text: textController.text,
                  position: position,
                  color: selectedColor,
                  fontSize: selectedFontSize,
                  fontFamily: selectedFont,
                );
                Provider.of<DrawingProvider>(context, listen: false)
                    .addTextEntry(textEntry);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
