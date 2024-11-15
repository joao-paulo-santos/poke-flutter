import 'package:flutter/material.dart';
import 'package:poke_flutter/core/models/pokemon.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonItem extends StatelessWidget {
  final PokemonModel pokemon;
  const PokemonItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 140,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: OverflowBox(
              maxHeight: 100,
              maxWidth: 100,
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return const Text("Image not found");
                },
              ),
            ),
          ),
          Text(pokemon.name),
        ],
      ),
    );
  }
}
