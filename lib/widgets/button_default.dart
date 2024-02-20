import 'package:flutter/material.dart';
import '../res/colors/colors.dart';
import '../widgets/text_default.dart';

class ButtonDefault extends StatelessWidget {
  final String content;
  final Function onTap;

  const ButtonDefault({required this.content, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onTap();
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor, minimumSize: const Size(300, 50)),
        child: TextDefault(content, 30, Colors.white, true));
  }
}
