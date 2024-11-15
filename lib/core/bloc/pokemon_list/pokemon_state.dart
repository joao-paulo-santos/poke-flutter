part of 'pokemon_bloc.dart';

class PokemonState {
  final List<PokemonModel> pokemons;

  PokemonState(this.pokemons);
}

class PokemonInitial extends PokemonState {

  PokemonInitial() : super([]);
}

class PokemonLoadingState extends PokemonState {

  PokemonLoadingState(super.pokemons);
}

class PokemonLoadedState extends PokemonState {

  PokemonLoadedState(super.pokemons);
}

class PokemonErrorState extends PokemonState {
  final String error;

  PokemonErrorState(this.error, super.pokemons);
}