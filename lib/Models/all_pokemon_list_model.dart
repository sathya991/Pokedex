// To parse this JSON data, do
//
//     final allPokemonModel = allPokemonModelFromJson(jsonString);

import 'dart:convert';

AllPokemonModel allPokemonModelFromJson(String str) =>
    AllPokemonModel.fromJson(json.decode(str));

String allPokemonModelToJson(AllPokemonModel data) =>
    json.encode(data.toJson());

class AllPokemonModel {
  AllPokemonModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String next;
  dynamic previous;
  List<Result> results;

  factory AllPokemonModel.fromJson(Map<String, dynamic> json) =>
      AllPokemonModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<Result>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.name,
    required this.url,
    required this.id,
  });

  String name;
  String url;
  int id;
  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";

  factory Result.fromJson(Map<String, dynamic> json) {
    final name = json["name"];
    final url = json["url"];
    final id = int.parse(url.split('/')[6]);
    return Result(id: id, name: name, url: url);
  }

  Map<String, dynamic> toJson() => {"name": name, "url": url};
}

var pokemonTypes = [
  "All",
  "Normal",
  "Fighting",
  "Flying",
  "Poison",
  "Ground",
  "Rock",
  "Bug",
  "Ghost",
  "Steel",
  "Fire",
  "Water",
  "Grass",
  "Electric",
  "Psychic",
  "Ice",
  "Dragon",
  "Dark",
  "Fairy",
  "Unknown",
  "Shadow"
];
