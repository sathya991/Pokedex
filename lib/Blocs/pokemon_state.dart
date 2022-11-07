import 'package:flutter/material.dart';
import 'package:pokedex/Models/all_pokemon_list_model.dart';
import 'package:pokedex/Models/pokemon_model.dart';

abstract class PokemonStates {}

class InitialState extends PokemonStates {}

class LoadingState extends PokemonStates {}

class LoadedState extends PokemonStates {
  final List<dynamic> pokemonlist;
  final int totalCount;

  LoadedState({required this.pokemonlist, required this.totalCount});
}

class FailureState extends PokemonStates {
  final String error;

  FailureState({required this.error});
}

class MenuState extends PokemonStates {
  final String title;
  final int type;
  final bool clicked;
  MenuState({required this.title, required this.type, required this.clicked});
}

class PageState extends PokemonStates {
  final int page;
  final int totalCount;
  PageState({required this.page, required this.totalCount});
}

class PokemonViewState extends PokemonStates {
  final String name;
  final String image;
  final List<Stat> stats;
  final List<Type> types;
  final List<AbilityElement> abilities;
  PokemonViewState(
      {required this.name,
      required this.image,
      required this.stats,
      required this.types,
      required this.abilities});
}
