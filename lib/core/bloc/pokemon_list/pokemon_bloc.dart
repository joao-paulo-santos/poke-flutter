import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_flutter/core/models/pokemon.dart';
import 'package:poke_flutter/core/services/pokemon_service.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonService _pokemonService;
  int _currentPage = 1;
  bool complete = false;

  PokemonBloc(this._pokemonService) : super(PokemonInitial()){
    on<FetchPokemonsEvent>((event, emit) async {
      if(complete) return;

      final oldPokemons = state.pokemons;
      
      emit(PokemonLoadingState(oldPokemons));

      try {
        final newPokemons = await _pokemonService.fetchPokemons(_currentPage);
        if(newPokemons.isEmpty){
          complete = true;
        }

        emit(PokemonLoadedState([...oldPokemons, ...newPokemons]));
        _currentPage++;
      } catch (error) {
        emit(PokemonErrorState(error.toString(),oldPokemons));
      }
    });
    on<ResetPokemonsEvent>((event, emit) async {
      emit(PokemonLoadedState(state.pokemons));
    });
  }
}