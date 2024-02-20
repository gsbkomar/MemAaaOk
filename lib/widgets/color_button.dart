import 'package:flutter/material.dart';

class ColorButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const ColorButton(this.color, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.circle, color: color),
      onPressed: onPressed,
    );
  }
}