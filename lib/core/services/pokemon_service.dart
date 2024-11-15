import 'package:dio/dio.dart';
import 'package:poke_flutter/core/models/pokemon.dart';

class PokemonService {
  final Dio _dio;

  PokemonService(this._dio);

  Future<List<PokemonModel>> fetchPokemons(int page) async {
    final response = await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=20&offset=${page * 20 - 20}');
    return PokemonModel.parsePokemons(response.data['results']);
  }
}