class PokemonModel{
  String name;
  int id;

  String get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
  }
      
  PokemonModel({
    required this.name,
    required this.id
  });


  static List<PokemonModel> parsePokemons(dynamic data) {
    final pokemons = <PokemonModel>[];
    for (final item in data) {
      final name = item['name'] as String;
      final id = int.tryParse(item['url'].split('/')[6]) ?? 0; // Extract ID from URL
      pokemons.add(PokemonModel(name: name, id: id));
    }
    return pokemons;
  }
}