import 'package:flutter/material.dart';
import 'package:meme_generator/res/colors/colors.dart';
import 'package:meme_generator/screen/create_sample.dart';
import 'package:meme_generator/screen/meme_generator_screen.dart';
import 'package:meme_generator/widgets/button_default.dart';
import 'package:meme_generator/widgets/image_background.dart';

import '../local/sample_list.dart';
import '../widgets/button_small.dart';
import '../widgets/text_default.dart';

class SampleScreen extends StatelessWidget {
  const SampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            const ImageBackground(imagePath: 'back_sample.jpg'),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 10, right: 10),
              child: ListView.builder(
                itemCount: sampleList.length,
                itemBuilder: (context, index) {
                  final story = sampleList[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: Card(
                          color: primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 150,
                              width: 350,
                              child: GestureDetector(
                                child: Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          index == 0
                                              ? 'https://sun9-41.userapi.com/impg/im-JrP2r8-sD-FHfjdbQcl9hjwJJ05LYQfQWxQ/mM8BZJ4yX7U.jpg?size=1080x1196&quality=96&sign=b358214be1aaf167d2e4c9ffa3e0561e&c_uniq_tag=Ang0KTKJe2aCHUW3xAnaSALs9aDqWttYWivLFT_fiWk&type=album'
                                              : 'https://tmsearch.onlinepatent.ru/images/70e/70e84af0-c6ee-41b0-ad43-d2be8eeb3d0e.jpg',
                                          height: 150,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        )),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: TextDefault(story.title, 25,
                                            Colors.white, false)),
                                  ],
                                ),
                                onTap: () {
                                  _showStartSampleDialog(context, index);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (index + 2 > sampleList.length)
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ButtonDefault(
                              content: 'Создать',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateSampleScreen()));
                              }),
                        )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStartSampleDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          title:
              const TextDefault('Согласны? Узнали?', 20, secondaryColor, true),
          content: TextDefault(
              'Начать с шаблона \'${sampleList[index].title}\'.',
              18,
              secondaryColor,
              true),
          actions: [
            ButtonSmall(
              content: 'Назад',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ButtonSmall(
              content: 'Начать',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MemeGeneratorScreen(sampleDto: sampleList[index])),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
