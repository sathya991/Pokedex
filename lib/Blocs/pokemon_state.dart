import 'package:pokedex/Models/all_pokemon_list_model.dart';

abstract class PokemonStates {}

class InitialState extends PokemonStates {}

class LoadingState extends PokemonStates {}

class LoadedState extends PokemonStates {
  final List pokemonlist;
  final String nextPage;

  LoadedState({required this.pokemonlist, required this.nextPage});
}

class FailureState extends PokemonStates {
  final String error;

  FailureState({required this.error});
}

abstract class TypeStates {}

class MenuState extends PokemonStates {
  final String title;
  final int type;
  final bool clicked;
  MenuState({required this.title, required this.type, required this.clicked});
}
