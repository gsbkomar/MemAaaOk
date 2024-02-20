import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_generator/data/dtos/sample_dto.dart';
import 'package:meme_generator/local/sample_list.dart';
import 'package:meme_generator/screen/sample_screen.dart';
import 'package:meme_generator/widgets/button_small.dart';
import 'package:meme_generator/widgets/image_background.dart';
import 'package:meme_generator/widgets/image_edit.dart';
import 'package:meme_generator/widgets/text_edit.dart';

import '../res/colors/colors.dart';
import '../widgets/text_default.dart';

class CreateSampleScreen extends StatefulWidget {
  const CreateSampleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateSampleScreen();
}

class _CreateSampleScreen extends State<CreateSampleScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  SampleDto sampleDto = SampleDto(edit: [
    const TextEdit(
        initSize: 22,
        initColor: Colors.white,
        initOffset: Offset(170, 500),
        initContent: 'Ваш текст..'),
  ], image: [
    const ImageEdit(
      initOffset: Offset(55, 280),
      initWidth: 300,
    )
  ], title: 'Заголовок');

  void _createNewPhoto() {
    setState(() {
      sampleDto.image.add(const ImageEdit(
        initOffset: Offset(100, 100),
        initWidth: 300,
      ));
    });
  }

  void _createNewText() {
    setState(() {
      sampleDto.edit.add(const TextEdit(
          initSize: 22,
          initColor: Colors.white,
          initOffset: Offset(170, 500),
          initContent: 'Text'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          const ImageBackground(imagePath: 'back_sample.jpg'),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black45,
          ),
          Positioned(
              top: 50,
              left: 5,
              child: Card(
                color: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 175,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SampleScreen()),
                            );
                          },
                          child: Image.asset(
                            'assets/images/arrow_back.png',
                            width: 35,
                            height: 35,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ButtonSmall(
                            content: 'Текст +',
                            onTap: () {
                              _createNewText();
                            })
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 50,
              right: 5,
              child: Card(
                color: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 175,
                    child: Row(
                      children: [
                        ButtonSmall(
                            content: 'Фото +',
                            onTap: () {
                              _createNewPhoto();
                            }),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            showSaveDialog();
                          },
                          child: Image.asset('assets/images/save.png',
                              width: 35, height: 35, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Stack(children: [
            for (int i = 0; i < sampleDto.image.length; i++)
              ImageEdit(
                initOffset: sampleDto.image[i].initOffset,
                initWidth: sampleDto.image[i].initWidth,
              ),
            for (int i = 0; i < sampleDto.edit.length; i++)
              TextEdit(
                initSize: sampleDto.edit[i].initSize,
                initColor: sampleDto.edit[i].initColor,
                initOffset: sampleDto.edit[i].initOffset,
                initContent: sampleDto.edit[i].initContent,
              ),
          ]),
        ]));
  }

  void showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: const TextDefault('Сохранение', 20, secondaryColor, true),
          content: SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextDefault(
                    'Придумайте название шаблону', 18, secondaryColor, true),
                SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: secondaryColor),
                    ),
                  ),
                  controller: _textEditingController,
                ),
              ],
            ),
          ),
          actions: [
            ButtonSmall(
              content: 'Ок',
              onTap: () {
                sampleDto.title = _textEditingController.text;
                _saveSample();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SampleScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _saveSample() {
    sampleList.add(sampleDto);
  }
}
