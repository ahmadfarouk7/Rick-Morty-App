import 'package:flutter/material.dart';
import 'package:rokyapp/constants/my_colors.dart';
import 'package:rokyapp/constants/strings.dart';
import 'package:rokyapp/data/models/characters.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({super.key, required this.character});

  final Character character;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,
              arguments: character);
        },
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black45,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.name,
              style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.myWhite,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          child: Hero(
            tag: character.id,
            child: Container(
              color: MyColors.myGrey,
              child: character.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.image)
                  : Image.asset('assets/images/businessman.png'),
            ),
          ),
        ),
      ),
    );
  }
}
