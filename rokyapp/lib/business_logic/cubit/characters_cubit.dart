import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rokyapp/data/models/characters.dart';
import 'package:rokyapp/data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  late List<Character> characters;

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  // To receive the data from the repository
  Future<List<Character>> getAllCharacters() async {
    try {
      final characters = await charactersRepository.getAllCharacters();
      emit(CharactersLoaded(characters));
      this.characters = characters;
      return characters;
    } catch (error) {
      //  emit(CharactersError(error.toString()));
      return [];
    }
  }
}
