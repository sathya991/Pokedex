import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/Blocs/pokemon_event.dart';
import 'package:pokedex/Blocs/pokemon_state.dart';

class TypeBloc extends Bloc<PokemonEvents, PokemonStates> {
  TypeBloc() : super(InitialState()) {
    on<PokemonEvents>((event, emit) async {
      if (event is PokemonTypePageRequest) {
        if (event.type != 0) {
          emit(MenuState(
              title: event.name, type: event.type, clicked: event.clicked));
        } else if (event.type == 0) {
          if (event.clicked == true) {
            emit(MenuState(title: "All", type: 0, clicked: true));
          } else {
            emit(MenuState(title: "All", type: 0, clicked: false));
          }
        }
      }
    });
  }
}
