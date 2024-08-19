import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rokyapp/business_logic/cubit/characters_cubit.dart';
import 'package:rokyapp/constants/my_colors.dart';
import 'package:rokyapp/data/models/characters.dart';
import 'package:rokyapp/presentation/widgets/character_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Character> allCharacters = []; // Initialize as empty list
  List<Character> searchedForCharacters = []; // Initialize as empty list
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Request data from the Cubit
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters =
              state.characters; // Assign characters to allCharacters
          return buildLoadedListWidget();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    final List<Character> displayList = _searchTextController.text.isEmpty
        ? allCharacters
        : searchedForCharacters;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items in each row
        childAspectRatio: 2 / 3, // Aspect ratio of the grid items
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: displayList.length,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (ctx, index) {
        return CharacterItem(
          character: displayList[index],
        );
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      onChanged: (searchedCharacter) {
        addSearchForCharacters(searchedCharacter);
      },
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Search characters...',
        filled: true,
        fillColor: MyColors.myYellow,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  void addSearchForCharacters(String searchedCharacter) {
    setState(() {
      searchedForCharacters = allCharacters
          .where((character) => character.name
              .toLowerCase()
              .contains(searchedCharacter.toLowerCase()))
          .toList();
    });
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _clearSearch();
            Navigator.pop(context); // Dismiss the search field
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _startSearch,
        ),
      ];
    }
  }

  Widget _buildAppbarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey, fontWeight: FontWeight.w700),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        actions: _buildAppBarActions(),
        title: _isSearching ? _buildSearchField() : _buildAppbarTitle(),
      ),
      body: buildBlocWidget(),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(
      () {
        _isSearching = false;
      },
    );
  }

  void _clearSearch() {
    setState(
      () {
        _searchTextController.clear();
        searchedForCharacters.clear();
      },
    );
  }
}
