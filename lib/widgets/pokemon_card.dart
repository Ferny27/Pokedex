import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_response.dart';

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
            
            _PokemonImage(image: pokemon.sprites.frontDefault),
    
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

  const _PokemonImage({
    Key? key, 
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 96,
      child: FadeInImage(
        placeholder: const AssetImage("assets/loading.gif"),
        image: NetworkImage(image),
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
            Text('N.° ${id.padLeft(3,'0')}', style: const TextStyle(color: Colors.black38)),
            _PokemonTypeBadges(badges: typeBadges),
            Text(name, 
              style: const TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis
              )
            )
          ],
        ),
      ),
    );
  }
}

class _PokemonTypeBadges extends StatelessWidget {
  final List<Widget> badges;

  const _PokemonTypeBadges({super.key, required this.badges});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:20,
      child: Table(
        children: [
          TableRow(
            children: badges 
          )
        ],
      )
    );
  }
}