import 'package:meme_generator/widgets/image_edit.dart';
import 'package:meme_generator/widgets/text_edit.dart';

abstract class Sample {
  abstract List<ImageEdit> image;
  abstract List<TextEdit> edit;
  abstract String title;
}