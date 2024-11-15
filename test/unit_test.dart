// This is an example unit test.
//
// A unit test tests a single function, method, or class. To learn more about
// writing unit tests, visit
// https://flutter.dev/to/unit-testing

import 'package:flutter_test/flutter_test.dart';
import 'package:poke_flutter/core/bloc/pokemon_list/pokemon_bloc.dart';
import 'package:poke_flutter/core/models/pokemon.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:poke_flutter/core/services/pokemon_service.dart';

class MockDio extends Mock implements Dio {}
void main() {
  group('Pokemon Model Tests', () {
    test('parsePokemons should parse pokemon data correctly', () {
      final jsonData = {
        'results': [
          {'name': 'Pikachu', 'url': 'https://pokeapi.co/api/v2/pokemon/25/'},
          {'name': 'Charmander', 'url': 'https://pokeapi.co/api/v2/pokemon/4/'},
        ]
      };

      final pokemons = PokemonModel.parsePokemons(jsonData['results']);

      expect(pokemons, hasLength(2));
      expect(pokemons[0].name, 'Pikachu');
      expect(pokemons[0].id, 25);
      expect(pokemons[1].name, 'Charmander');
      expect(pokemons[1].id, 4);
    });

    test('imageUrl should generate the correct URL', () {
      final pokemon = PokemonModel(name: 'Pikachu', id: 25);

      expect(pokemon.imageUrl, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png');
    });
  });
  group('Pokemon Bloc Tests', () {
    test('Fetches pokemons and emits correct states', () async {
      final mockDio = MockDio();

      when(() => mockDio.get(any())).thenAnswer((_) async => Response(
        data: {
          'results': [
            {'name': 'Pikachu', 'url': 'https://pokeapi.co/api/v2/pokemon/25/'},
            {'name': 'Charmander', 'url': 'https://pokeapi.co/api/v2/pokemon/4/'},
          ]
        },
        statusCode: 200, requestOptions: RequestOptions(),
      ));

      final pokemonBloc = PokemonBloc(PokemonService(mockDio));

      pokemonBloc.add(FetchPokemonsEvent());

      await expectLater(
        pokemonBloc.stream,
        emitsInOrder([
          isA<PokemonLoadingState>(),
          isA<PokemonLoadedState>(),
        ]),
      );

      verify(() => mockDio.get(any())).called(1);
      verifyNoMoreInteractions(mockDio);
    });
  });
}
