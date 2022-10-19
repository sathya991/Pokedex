// To parse this JSON data, do
//
//     final typePokemonModel = typePokemonModelFromJson(jsonString);

import 'dart:convert';

TypePokemonModel typePokemonModelFromJson(String str) =>
    TypePokemonModel.fromJson(json.decode(str));

String typePokemonModelToJson(TypePokemonModel data) =>
    json.encode(data.toJson());

class TypePokemonModel {
  TypePokemonModel({
    required this.id,
    required this.name,
    required this.pokemonT,
  });

  int id;
  String name;
  List pokemonT;

  factory TypePokemonModel.fromJson(Map<String, dynamic> json) =>
      TypePokemonModel(
        id: json["id"],
        name: json["name"],
        pokemonT: List.from(
            json["pokemon"].map((x) => PokemonElement.fromJson(x).pokemon)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "pokemon": List<dynamic>.from(pokemonT.map((x) => x.toJson())),
      };
}

class PokemonElement {
  PokemonElement({
    required this.pokemon,
    required this.slot,
  });

  PokemonPokemon pokemon;
  int slot;

  factory PokemonElement.fromJson(Map<String, dynamic> json) => PokemonElement(
        pokemon: PokemonPokemon.fromJson(json["pokemon"]),
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "pokemon": pokemon.toJson(),
        "slot": slot,
      };
}

class PokemonPokemon {
  PokemonPokemon({
    required this.name,
    required this.url,
    required this.id,
  });

  String name;
  String url;
  int id;
  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
  factory PokemonPokemon.fromJson(Map<String, dynamic> json) {
    final name = json["name"];
    final url = json["url"];
    final id = int.parse(url.split('/')[6]);
    return PokemonPokemon(name: name, url: url, id: id);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
