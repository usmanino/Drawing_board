import 'package:drawing_app/drawing/model/text_entry_model.dart';
import 'package:drawing_app/drawing/view_model/drawing_provider.dart';
import 'package:drawing_app/drawing/widget/color_sheet.dart';
import 'package:drawing_app/drawing/widget/drawing_canvas.dart';
import 'package:drawing_app/drawing/widget/input_dialog.dart';
import 'package:drawing_app/drawing/widget/tickness_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DrawingScreen extends StatelessWidget {
  final GlobalKey _globalKey = GlobalKey();

  DrawingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5E5B3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Row(
          children: [
            Row(
              children: [
                Image.asset('assets/images/heart_icon.png',
                    width: 24, height: 24),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://example.com/user_profile.jpg'), // Replace with actual user image URL
          ),
          SizedBox(width: 8),
          Text(
            'Usman Bello',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(width: 16),
        ],
      ),
      body:
          Consumer<DrawingProvider>(builder: (context, drawingProvider, child) {
        return Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: RepaintBoundary(
                          key: _globalKey,
                          child: const DrawingCanvas(),
                        ),
                      ),
                    ],
                  ),
                ),
                // ...drawingProvider.textEntries.asMap().entries.map((entry) {
                //   int index = entry.key;
                //   TextEntry textEntry = entry.value;

                //   return Positioned(
                //     left: textEntry.position.dx,
                //     top: textEntry.position.dy,
                //     child: GestureDetector(
                //       onPanUpdate: (details) {
                //         Offset newPosition = textEntry.position + details.delta;
                //         TextEntry updatedEntry = TextEntry(
                //           position: newPosition,
                //           text: textEntry.text,
                //           color: textEntry.color,
                //           fontSize: textEntry.fontSize,
                //           fontFamily: textEntry.fontFamily,
                //           rotation: textEntry.rotation,
                //         );
                //         Provider.of<DrawingProvider>(context, listen: false)
                //             .updateTextEntry(index, updatedEntry);
                //       },
                //       onLongPress: () {
                //         // Enable rotation
                //         showRotationDialog(context, index);
                //       },
                //       child: Transform.rotate(
                //         angle: textEntry.rotation,
                //         child: Text(
                //           textEntry.text,
                //           style: TextStyle(
                //             color: textEntry.color,
                //             fontSize: textEntry.fontSize,
                //             fontFamily: textEntry.fontFamily,
                //           ),
                //         ),
                //       ),
                //     ),
                //   );
                // }),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: const Color(0xFFF5E5B3),
                    child: ListView.builder(
                      itemCount:
                          Provider.of<DrawingProvider>(context).slides.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Slide ${index + 1}'),
                          onTap: () {
                            Provider.of<DrawingProvider>(context, listen: false)
                                .switchSlide(index);
                          },
                          selected: index ==
                              Provider.of<DrawingProvider>(context)
                                  .currentSlideIndex,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFF5E5B3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.brush, color: Colors.black),
              onPressed: () {
                showColorPicker(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.format_bold, color: Colors.black),
              onPressed: () {
                showThicknessSlider(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.text_fields, color: Colors.black),
              onPressed: () {
                showTextInputDialog(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.text_rotation_angledown,
                  color: Colors.black),
              onPressed: () {
                showTextPositionDialog(context);
              },
            ),
            // IconButton(
            //   icon: const Icon(Icons.crop_square, color: Colors.black),
            //   onPressed: () {
            //     // Provider.of<DrawingProvider>(context, listen: false).setShape(DrawingShape.rectangle);
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.circle, color: Colors.black),
            //   onPressed: () {
            //     // Provider.of<DrawingProvider>(context, listen: false).setShape(DrawingShape.circle);
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.show_chart, color: Colors.black),
            //   onPressed: () {
            //     // Provider.of<DrawingProvider>(context, listen: false).setShape(DrawingShape.line);
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.color_lens, color: Colors.black),
            //   onPressed: () {
            //     Provider.of<DrawingProvider>(context, listen: false)
            //         .updateBackgroundColor(Colors.red);
            //     // showThicknessSlider(context);
            //   },
            // ),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.cleaning_services, color: Colors.black),
            // ),
            IconButton(
              icon: const Icon(Icons.image, color: Colors.black),
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  // Provider.of<DrawingProvider>(context, listen: false)
                  //     .addImage(image);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                Provider.of<DrawingProvider>(context, listen: false)
                    .clearCanvas();
              },
            ),
            IconButton(
              icon: const Icon(Icons.undo, color: Colors.black),
              onPressed: () {
                Provider.of<DrawingProvider>(context, listen: false).undo();
              },
            ),
            IconButton(
              icon: const Icon(Icons.redo, color: Colors.black),
              onPressed: () {
                Provider.of<DrawingProvider>(context, listen: false).redo();
              },
            ),
            IconButton(
              icon: const Icon(Icons.save, color: Colors.black),
              onPressed: () {
                Provider.of<DrawingProvider>(context, listen: false)
                    .saveDrawing(_globalKey);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                Provider.of<DrawingProvider>(context, listen: false)
                    .createNewSlide();
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showRotationDialog(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (context) {
      double rotation = Provider.of<DrawingProvider>(context, listen: false)
          .textEntries[index]
          .rotation;

      return AlertDialog(
        title: const Text('Rotate Text'),
        content: Slider(
          value: rotation,
          min: 0.0,
          max: 6.28, // 2 * pi for full rotation
          onChanged: (double value) {
            rotation = value;
            Provider.of<DrawingProvider>(context, listen: false)
                .updateTextRotation(index, value);
          },
        ),
        actions: [
          TextButton(
            child: const Text('Done'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showTextPositionDialog(BuildContext context) {
  final drawingProvider = Provider.of<DrawingProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Position Text'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: ListView.builder(
            itemCount: drawingProvider.textEntries.length,
            itemBuilder: (context, index) {
              final textEntry = drawingProvider.textEntries[index];
              return ListTile(
                title: Text(textEntry.text),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Edit Text Position'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Move Text:'),
                              Slider(
                                value: textEntry.position.dx,
                                min: 0,
                                max: MediaQuery.of(context).size.width,
                                onChanged: (double value) {
                                  drawingProvider.updateTextEntry(
                                    index,
                                    textEntry.copyWith(
                                      position:
                                          Offset(value, textEntry.position.dy),
                                    ),
                                  );
                                },
                              ),
                              Slider(
                                value: textEntry.position.dy,
                                min: 0,
                                max: MediaQuery.of(context).size.height,
                                onChanged: (double value) {
                                  drawingProvider.updateTextEntry(
                                    index,
                                    textEntry.copyWith(
                                      position:
                                          Offset(textEntry.position.dx, value),
                                    ),
                                  );
                                },
                              ),
                              const Text('Rotate Text:'),
                              Slider(
                                value: textEntry.rotation,
                                min: 0.0,
                                max: 6.28, // 2 * pi for full rotation
                                onChanged: (double value) {
                                  drawingProvider.updateTextEntry(
                                    index,
                                    textEntry.copyWith(rotation: value),
                                  );
                                },
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Done'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
