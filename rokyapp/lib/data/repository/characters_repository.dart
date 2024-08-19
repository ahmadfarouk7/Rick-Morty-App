import 'package:rokyapp/data/web_services/characters_web_services.dart';
import '../models/characters.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository({required this.charactersWebServices});

  Future<List<Character>> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters
        .map((character) => Character.fromJson(character))
        .toList();
  }
}
