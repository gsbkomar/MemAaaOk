import 'package:meme_generator/domain/models/sample.dart';
import 'package:meme_generator/widgets/image_edit.dart';
import 'package:meme_generator/widgets/text_edit.dart';

class SampleDto extends Sample {
  @override
  List<TextEdit> edit;

  @override
  List<ImageEdit> image;

  @override
  String title;

  SampleDto({required this.edit, required this.image, required this.title});
}
