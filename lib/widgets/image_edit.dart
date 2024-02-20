import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../res/colors/colors.dart';
import 'button_small.dart';
import 'common/decoration.dart';
import 'text_default.dart';

class ImageEdit extends StatefulWidget {
  final Offset initOffset;
  final double initWidth;

  const ImageEdit(
      {super.key, required this.initOffset, required this.initWidth});

  @override
  State<StatefulWidget> createState() {
    return _ImageEdit();
  }
}

class _ImageEdit extends State<ImageEdit> {
  XFile? _imageFile;
  XFile? _lastFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
      if (_imageFile != null) {
        _lastFile = _imageFile;
      }
    });
  }

  Offset _offsetImage = Offset(300.0, 150.0);
  double _widthImage = 300;
  double _heightImage = 300;

  @override
  void initState() {
    _offsetImage = widget.initOffset;
    _widthImage = widget.initWidth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offsetImage.dx,
      top: _offsetImage.dy,
      child: GestureDetector(
        onTap: () {
          _showImageSettingsDialog(context);
        },
        child: Draggable(
          feedback: Material(
            color: Colors.transparent,
            child: SizedBox(
              width: _widthImage,
              // height: _heightImage,
              child: DecoratedBox(
                decoration: decoration,
                child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: _imageFile == null && _lastFile == null
                        ? Image.network(
                            'https://tmsearch.onlinepatent.ru/images/70e/70e84af0-c6ee-41b0-ad43-d2be8eeb3d0e.jpg',
                            fit: BoxFit.cover,
                          )
                        : _lastFile != null && _imageFile == null
                            ? Image.file(
                                File(_lastFile!.path),
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(_imageFile!.path),
                                fit: BoxFit.cover,
                              )),
              ),
            ),
          ),
          childWhenDragging: Container(),
          child: SizedBox(
            width: _widthImage,
            //height: _heightImage,
            child: DecoratedBox(
              decoration: decoration,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: _imageFile == null && _lastFile == null
                    ? Image.network(
                        'https://tmsearch.onlinepatent.ru/images/70e/70e84af0-c6ee-41b0-ad43-d2be8eeb3d0e.jpg',
                        fit: BoxFit.cover,
                      )
                    : _lastFile != null && _imageFile == null
                        ? Image.file(
                            File(_lastFile!.path),
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(_imageFile!.path),
                            fit: BoxFit.cover,
                          ),
              ),
            ),
          ),
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            setState(() {
              _offsetImage = offset;
            });
          },
        ),
      ),
    );
  }

  void _showImageSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateWithDialog) {
            return AlertDialog(
              backgroundColor: primaryColor,
              title: const TextDefault('Настройки', 20, Colors.white, true),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextDefault(
                      'Размер изображения', 16, Colors.white, true),
                  Slider(
                    activeColor: secondaryColor,
                    value: _widthImage,
                    min: 100.0,
                    max: 380.0,
                    onChanged: (value) {
                      setStateWithDialog(() {
                        _widthImage = value;
                      });
                      setState(() {
                        _widthImage = value;
                        _heightImage = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  const TextDefault(
                      'Выбрать другое фото', 16, Colors.white, true),
                  ButtonSmall(
                      content: 'Галерея',
                      onTap: () {
                        _pickImage();
                      })
                ],
              ),
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
      },
    );
  }
}
