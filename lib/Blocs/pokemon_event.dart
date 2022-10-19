abstract class PokemonEvents {}

class PokemonPageRequest extends PokemonEvents {
  final int page;
  PokemonPageRequest({required this.page});
}

class PokemonTypePageRequest extends PokemonEvents {
  final int page;
  final int type;
  final String name;
  final bool clicked;
  PokemonTypePageRequest({
    required this.page,
    required this.type,
    required this.clicked,
    required this.name,
  });
}
