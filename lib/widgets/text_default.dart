import 'package:flutter/material.dart';

class TextDefault extends StatelessWidget {
  final String content;
  final double size;
  final Color color;
  final bool isCenterAlign;

  const TextDefault(this.content, this.size, this.color, this.isCenterAlign,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(content,
        textAlign: isCenterAlign ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontSize: size,
          color: color,
        ));
  }
}
