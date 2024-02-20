import 'package:flutter/material.dart';

import '../data/dtos/sample_dto.dart';
import '../widgets/image_edit.dart';
import '../widgets/text_edit.dart';

List<SampleDto> sampleList = [
  SampleDto(edit: [
    const TextEdit(
        initSize: 22,
        initColor: Colors.white,
        initOffset: Offset(170, 500),
        initContent: 'Text'),
    const TextEdit(
        initSize: 18,
        initColor: Colors.white,
        initOffset: Offset(150, 550),
        initContent: 'Secondary text...')
  ], image: [
    const ImageEdit(initOffset: Offset(55, 280), initWidth: 300)
  ], title: 'Демотиватор')
];
