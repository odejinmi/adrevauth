import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ImageFilledText extends StatefulWidget {
  final String text;
  final String imagePath;
  final double fontSize;
  final Color strokeColor;
  final double strokeWidth;

  const ImageFilledText({
    super.key,
    required this.text,
    required this.imagePath,
    this.fontSize = 80,
    this.strokeColor = Colors.purple,
    this.strokeWidth = 6,
  });

  @override
  State<ImageFilledText> createState() => _ImageFilledTextState();
}

class _ImageFilledTextState extends State<ImageFilledText> {
  ui.Image? image;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      final ByteData data = await rootBundle.load(widget.imagePath);
      final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
      final frame = await codec.getNextFrame();

      if (mounted) {
        setState(() {
          image = frame.image;
        });
      }
    } catch (e) {
      debugPrint('Error loading image: $e');
      setState(() => hasError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return const Text('Error loading image');
    }

    if (image == null) {
      return const SizedBox(
        height: 80,
        width: 80,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Stack(
  alignment: Alignment.center,
  children: [

    Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontWeight: FontWeight.w900,
        fontFamily: 'Inter',
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = widget.strokeWidth
          ..color = widget.strokeColor,
      ),
    ),

    // Image fill
    ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return ImageShader(
          image!,
          TileMode.repeated,
          TileMode.repeated,
          Matrix4.identity().storage,
        );
      },
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
    ),

    // // Gradient overlay
    // ShaderMask(
    //   blendMode: BlendMode.srcATop,
    //   shaderCallback: (bounds) {
    //     return const LinearGradient(
    //       colors: [Colors.yellow, Colors.orange],
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //     ).createShader(bounds);
    //   },
    //   child: Text(
    //     widget.text,
    //     style: TextStyle(
    //       fontSize: widget.fontSize,
    //       fontWeight: FontWeight.w900,
    //       color: Colors.white,
    //     ),
    //   ),
    // ),
  ],
);

  }
}




