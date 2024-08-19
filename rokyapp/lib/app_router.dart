import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokyapp/business_logic/cubit/characters_cubit.dart';
import 'package:rokyapp/constants/strings.dart';
import 'package:rokyapp/data/models/characters.dart';
import 'package:rokyapp/data/repository/characters_repository.dart';
import 'package:rokyapp/data/web_services/characters_web_services.dart';
import 'package:rokyapp/presentation/screens/character_details.dart';
import 'package:rokyapp/presentation/screens/characters.dart';

class AppRouter {
  //عشان اقدر استعمل الكيوبيت في اكتر من مكان
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository =
        CharactersRepository(charactersWebServices: CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  //لحد الي فوق

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => charactersCubit,
            child: const HomePage(),
          ),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  character: character,
                ));

        return null;
    }
    return null;
  }
}
