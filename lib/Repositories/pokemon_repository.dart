import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/Models/all_pokemon_list_model.dart';
import 'package:pokedex/Models/type_pokemon_model.dart';

class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<AllPokemonModel> getPokemons(int pageIndex) async {
    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };
    final uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParameters);

    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return AllPokemonModel.fromJson(json);
  }

  Future<TypePokemonModel> getPokemonByType(int pageIndex, int type) async {
    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };
    final uri = Uri.https(baseUrl, '/api/v2/type/$type', queryParameters);
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return TypePokemonModel.fromJson(json);
  }
}
