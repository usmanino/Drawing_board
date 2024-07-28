import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SlidePreview extends StatelessWidget {
  final GlobalKey globalKey;
  final int slideIndex;
  final Function(int) onTap;

  const SlidePreview({
    super.key,
    required this.globalKey,
    required this.slideIndex,
    required this.onTap,
  });

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 1.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(slideIndex),
      child: FutureBuilder<Uint8List>(
        future: _capturePng(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            );
          } else {
            return Container(
              width: 100,
              height: 100,
              color: Colors.grey[300],
              child: const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
