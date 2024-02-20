import 'package:flutter/material.dart';
import 'package:meme_generator/widgets/text_default.dart';

import '../res/colors/colors.dart';
import 'button_small.dart';
import 'color_button.dart';

class TextEdit extends StatefulWidget {
  final double initSize;
  final Color initColor;
  final Offset initOffset;
  final String initContent;

  const TextEdit(
      {super.key,
      required this.initSize,
      required this.initColor,
      required this.initOffset,
      required this.initContent});

  @override
  State<StatefulWidget> createState() => _TextEdit();
}

class _TextEdit extends State<TextEdit> {
  final TextEditingController _textEditingController = TextEditingController();

  double _fontSize = 0.0;
  Color _textColor = Colors.white;
  Offset _offset = Offset(0, 0);

  @override
  void initState() {
    _textEditingController.text = widget.initContent;
    _fontSize = widget.initSize;
    _textColor = widget.initColor;
    _offset = widget.initOffset;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _offset.dx,
      top: _offset.dy,
      child: GestureDetector(
        onTap: () {
          _editTextSettings(context);
        },
        child: Draggable(
          feedback: Material(
            color: Colors.transparent,
            child: Text(
              _textEditingController.text,
              style: TextStyle(fontSize: _fontSize, color: _textColor),
            ),
          ),
          childWhenDragging: Container(),
          child: Text(
            _textEditingController.text,
            style: TextStyle(fontSize: _fontSize, color: _textColor),
          ),
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            setState(() {
              _offset = offset;
            });
          },
        ),
      ),
    );
  }

  void _editTextSettings(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setStateWithDialog) {
            return AlertDialog(
              backgroundColor: primaryColor,
              title:
                  const TextDefault("Редактирование", 20, secondaryColor, true),
              content: SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  secondaryColor), // Change underline color here
                        ),
                      ),
                      controller: _textEditingController,
                    ),
                    const SizedBox(height: 10),
                    const TextDefault('Размер шрифта', 16, Colors.white, true),
                    Slider(
                      activeColor: secondaryColor,
                      value: _fontSize,
                      min: 10.0,
                      max: 50.0,
                      onChanged: (value) {
                        setStateWithDialog(() {
                          _fontSize = value;
                        });
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                    const TextDefault('Цвет текста', 16, Colors.white, true),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ColorButton(Colors.black, () {
                              setState(() {
                                _textColor = Colors.black;
                              });
                            }),
                            ColorButton(Colors.white, () {
                              setState(() {
                                _textColor = Colors.white;
                              });
                            }),
                            ColorButton(Colors.red, () {
                              setState(() {
                                _textColor = Colors.red;
                              });
                            }),
                            ColorButton(Colors.blue, () {
                              setState(() {
                                _textColor = Colors.blue;
                              });
                            }),
                            ColorButton(Colors.green, () {
                              setState(() {
                                _textColor = Colors.green;
                              });
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ColorButton(Colors.pink, () {
                              setState(() {
                                _textColor = Colors.pink;
                              });
                            }),
                            ColorButton(Colors.orange, () {
                              setState(() {
                                _textColor = Colors.orange;
                              });
                            }),
                            ColorButton(Colors.amberAccent, () {
                              setState(() {
                                _textColor = Colors.amberAccent;
                              });
                            }),
                            ColorButton(Colors.greenAccent, () {
                              setState(() {
                                _textColor = Colors.greenAccent;
                              });
                            }),
                            ColorButton(Colors.brown, () {
                              setState(() {
                                _textColor = Colors.brown;
                              });
                            }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                ButtonSmall(
                  content: 'Отмена',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ButtonSmall(
                  content: 'Сохранить',
                  onTap: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
        });
  }
}
