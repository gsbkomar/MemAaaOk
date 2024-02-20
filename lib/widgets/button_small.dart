import 'package:flutter/material.dart';
import '../res/colors/colors.dart';
import '../widgets/text_default.dart';

class ButtonSmall extends StatelessWidget {
  final String content;
  final Function onTap;

  const ButtonSmall({required this.content, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor, minimumSize: const Size(100, 35)),
        child: TextDefault(content, 16, Colors.white, true));

  }
}
