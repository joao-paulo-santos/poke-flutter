part of 'pokemon_bloc.dart';

abstract class PokemonEvent {
  
  PokemonEvent();
}

class FetchPokemonsEvent extends PokemonEvent {
  FetchPokemonsEvent();
}

class ResetPokemonsEvent extends PokemonEvent {
  ResetPokemonsEvent();
}