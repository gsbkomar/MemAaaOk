import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_generator/data/dtos/sample_dto.dart';
import 'package:meme_generator/local/sample_list.dart';
import 'package:meme_generator/res/colors/colors.dart';
import 'package:meme_generator/screen/sample_screen.dart';
import 'package:meme_generator/widgets/button_small.dart';
import 'package:meme_generator/widgets/image_background.dart';
import 'package:meme_generator/widgets/image_edit.dart';
import 'package:meme_generator/widgets/text_default.dart';
import 'package:meme_generator/widgets/text_edit.dart';
import '../widgets/common/decoration.dart';

class MemeGeneratorScreen extends StatefulWidget {
  final SampleDto sampleDto;

  const MemeGeneratorScreen({super.key, required this.sampleDto});

  @override
  State<StatefulWidget> createState() => _MemeGeneratorScreen();
}

class _MemeGeneratorScreen extends State<MemeGeneratorScreen> {
  GlobalKey _globalKey = GlobalKey();

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final String fileName = 'meme.png';
      final File file = File('${directory.path}/$fileName');
      await file.writeAsBytes(pngBytes);

      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngBytes),
          quality: 60);
      showDownloadImageToGalleryDialog();
    } catch (e) {}
  }

  void showDownloadImageToGalleryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title: const TextDefault('Уведомление', 20, secondaryColor, true),
          content: const TextDefault(
              'Мем успешно сохранен.', 18, secondaryColor, true),
          actions: [
            ButtonSmall(
              content: 'Ок',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<Directory> getTemporaryDirectory() async {
    return Directory.systemTemp;
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
              left: 10,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SampleScreen()),
                    );
                  },
                  child: Image.asset(
                    'assets/images/ic_menu.png',
                    width: 35,
                    height: 35,
                    color: Colors.white,
                  ))),
          Positioned(
              top: 50,
              right: 10,
              child: GestureDetector(
                  onTap: () {
                    _captureAndSavePng();
                  },
                  child: Image.asset('assets/images/save.png',
                      width: 35, height: 35, color: Colors.white))),
          RepaintBoundary(
            key: _globalKey,
            child: Stack(children: [
              if (sampleList.first == widget.sampleDto)
                Center(
                  child: ColoredBox(
                    color: Colors.black,
                    child: DecoratedBox(
                      decoration: decoration,
                      child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 20,
                          ),
                          child: SizedBox(
                            width: 360,
                            height: 360,
                          )),
                    ),
                  ),
                ),
              for (int i = 0; i < widget.sampleDto.image.length; i++)
                ImageEdit(
                  initOffset: widget.sampleDto.image[i].initOffset,
                  initWidth: widget.sampleDto.image[i].initWidth,
                ),
              for (int i = 0; i < widget.sampleDto.edit.length; i++)
                TextEdit(
                  initSize: widget.sampleDto.edit[i].initSize,
                  initColor: widget.sampleDto.edit[i].initColor,
                  initOffset: widget.sampleDto.edit[i].initOffset,
                  initContent: widget.sampleDto.edit[i].initContent,
                ),
            ]),
          ),
        ]));
  }
}
