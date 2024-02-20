import 'package:flutter/material.dart';

class ImageBackground extends StatelessWidget {

  final String imagePath;

  const ImageBackground({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topCenter,
          maxHeight: double.infinity,
          maxWidth: double.infinity,
          child: Image.asset(
            "assets/images/$imagePath",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}