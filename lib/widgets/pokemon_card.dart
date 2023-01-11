import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_response.dart';
import 'package:pokedex/widgets/widgets.dart';

class PokemonCard extends StatelessWidget {
  final PokemonResponse pokemon;

  const PokemonCard({
    Key? key, 
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => Navigator.pushNamed(context, 'pokemon', arguments: pokemon),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: pokemon.color!.withOpacity(0.15)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            _PokemonImage(image: pokemon.sprites.frontDefault, id: pokemon.id),
    
            _PokemonInfo(
              id: pokemon.id.toString(), 
              name: pokemon.getPokemonName(pokemon.name), 
              typeBadges: pokemon.getPokemonTypes(pokemon.types)
            ),
            
            const SizedBox(height:10)
            
          ],
        ),
      ),
    );
  }
}

class _PokemonImage extends StatelessWidget {

  final String image;
  final int id;

  const _PokemonImage({
    Key? key, 
    required this.image, 
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 96,
      child: Hero(
        tag: 'imagen_pokemon$id',
        child: FadeInImage(
          placeholder: const AssetImage("assets/loading.gif"),
          image: NetworkImage(image),
        ),
      ),
    );
  }
}

class _PokemonInfo extends StatelessWidget {

  final String id;
  final String name;
  final List<Widget> typeBadges;
  
  const _PokemonInfo({
    Key? key, 
    required this.id, 
    required this.name, 
    required this.typeBadges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'id_pokemon$id',
              flightShuttleBuilder: flightShuttleBuilder,              
              child: Text(
                'N.° ${id.padLeft(3,'0')}', 
                style: const TextStyle(color: Colors.black38))),
            Hero(tag: 'badges_pokemon${id}', child: PokemonTypeBadges(badges: typeBadges)),
            Hero(
              tag: 'nombre_pokemon$id',
              flightShuttleBuilder: flightShuttleBuilder,
              child: Text(name, 
                style: const TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.w500,
                  overflow: TextOverflow.ellipsis
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
