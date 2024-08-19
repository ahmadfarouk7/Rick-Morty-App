import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rokyapp/constants/my_colors.dart';
import 'package:rokyapp/data/models/characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharacterDetailsScreen({super.key, required this.character});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    characterInfo('Status : ', character.status),
                    buildDivider(300),
                    characterInfo('Species : ', character.species),
                    buildDivider(300),
                    characterInfo('Gender : ', character.gender),
                    buildDivider(300),
                    characterInfo(
                        'Origin: ', character.originName ?? 'Unknown'),
                    buildDivider(300),
                    const SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20,
                            color: MyColors.myWhite,
                            shadows: [
                              Shadow(
                                  blurRadius: 7,
                                  color: MyColors.myYellow,
                                  offset: Offset(0, 0)),
                            ]),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            FlickerAnimatedText('Watch the series now'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 400,
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600, // height of the image
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
        background: Hero(
            tag: character.id,
            child: Image.network(
              character.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        TextSpan(
            text: value,
            style: const TextStyle(color: MyColors.myWhite, fontSize: 16)),
      ]),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      color: MyColors.myYellow,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}
