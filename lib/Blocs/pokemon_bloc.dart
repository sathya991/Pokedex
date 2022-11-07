import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/Blocs/pokemon_event.dart';
import 'package:pokedex/Blocs/pokemon_state.dart';
import 'package:pokedex/Repositories/pokemon_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PokemonBloc extends Bloc<PokemonEvents, PokemonStates> {
  final _pokemonRepo = PokemonRepository();
  final refreshController = RefreshController();
  var curPage = 0;
  var curTypePage = 0;
  var maxPages = 0;
  PokemonBloc() : super(InitialState()) {
    on<PokemonEvents>((pokemonEvent, emit) async {
      if (pokemonEvent is PokemonPageRequest) {
        if (pokemonEvent.page == 0) {
          curPage = 0;
        }
        emit(LoadingState());
        try {
          final pageResponse = await _pokemonRepo.getPokemons(curPage);
          maxPages = (pageResponse.count / 200).ceil();
          if (curPage + 1 < maxPages) {
            curPage++;
          } else {
            refreshController.loadNoData();
          }
          emit(LoadedState(
              pokemonlist: pageResponse.results,
              totalCount: pageResponse.results.length));
        } catch (e) {
          emit(FailureState(error: e.toString()));
        }
      } else if (pokemonEvent is PokemonTypePageRequest) {
        if (pokemonEvent.page == 0) {
          curTypePage = 0;
        }
        emit(LoadingState());
        try {
          final pageResponse = await _pokemonRepo.getPokemonByType(
              curTypePage, pokemonEvent.type);
          maxPages = (pageResponse.pokemonT.length / 200).ceil();
          if (curTypePage + 1 < maxPages) {
            curTypePage++;
          } else {
            refreshController.loadNoData();
          }

          emit(LoadedState(
              pokemonlist: pageResponse.pokemonT,
              totalCount: pageResponse.pokemonT.length));
        } catch (e) {
          emit(FailureState(error: e.toString()));
        }
      } else if (pokemonEvent is PokemonViewRequest) {
        emit(LoadingState());
        try {
          final pageResponse =
              await _pokemonRepo.getPokemonData(pokemonEvent.id);
          emit(PokemonViewState(
              name: pageResponse.name,
              image: pageResponse.sprites.frontDefault,
              stats: pageResponse.stats,
              types: pageResponse.types,
              abilities: pageResponse.abilities));
        } catch (e) {
          emit(FailureState(error: e.toString()));
        }
      }
    });
  }
}
