import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/Blocs/pokemon_bloc.dart';
import 'package:pokedex/Blocs/pokemon_event.dart';
import 'package:pokedex/Blocs/type_bloc.dart';
import 'package:pokedex/Models/all_pokemon_list_model.dart';
import 'package:pokedex/Pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return PokemonBloc()..add(PokemonPageRequest(page: 0));
          }),
          BlocProvider(create: (context) {
            return TypeBloc()
              ..add(PokemonTypePageRequest(
                clicked: false,
                page: 0,
                type: 0,
                name: pokemonTypes[0],
              ));
          })
        ],
        child: const DashBoard(),
      ),
    );
  }
}
