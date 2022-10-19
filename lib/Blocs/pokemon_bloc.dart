import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/Blocs/pokemon_event.dart';
import 'package:pokedex/Blocs/pokemon_state.dart';
import 'package:pokedex/Repositories/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvents, PokemonStates> {
  final _pokemonRepo = PokemonRepository();
  PokemonBloc() : super(InitialState()) {
    on<PokemonEvents>((pokemonEvent, emit) async {
      if (pokemonEvent is PokemonPageRequest) {
        emit(LoadingState());
        try {
          final pageResponse =
              await _pokemonRepo.getPokemons(pokemonEvent.page);
          emit(LoadedState(
              pokemonlist: pageResponse.results, nextPage: pageResponse.next));
        } catch (e) {
          emit(FailureState(error: e.toString()));
        }
      } else if (pokemonEvent is PokemonTypePageRequest) {
        emit(LoadingState());
        try {
          final pageResponse = await _pokemonRepo.getPokemonByType(
              pokemonEvent.page, pokemonEvent.type);
          emit(LoadedState(pokemonlist: pageResponse.pokemon, nextPage: ""));
        } catch (e) {
          emit(FailureState(error: e.toString()));
        }
      }
    });
  }
}
