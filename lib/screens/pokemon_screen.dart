import 'package:flutter/material.dart';
import 'package:pokedex/models/models.dart';
import '../widgets/widgets.dart';

class PokemonScreen extends StatelessWidget {
   
  const PokemonScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final pokemon = ModalRoute.of(context)!.settings.arguments as PokemonResponse;

    return Scaffold(
      appBar: _PokemonAppBar(pokemon: pokemon, appBar: AppBar(),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
      
          _PokemonInfo(pokemon: pokemon)
      
        ]),
      ),
    );
  }
}

class _PokemonInfo extends StatelessWidget {
  const _PokemonInfo({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonResponse pokemon;

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [

        Container(
          width: 120,
          height: 120,
          child: Hero(
            tag: 'imagen_pokemon${pokemon.id}',
            child: Image(
              image: NetworkImage(pokemon.sprites.frontDefault),
              fit:BoxFit.cover
            ),
          ),
        ),

        const SizedBox(width: 10,),

        Expanded(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Hero(
                tag: 'id_pokemon${pokemon.id}',
                flightShuttleBuilder: flightShuttleBuilder,
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 30,
                  child: Text(
                    'N.° ${pokemon.id.toString().padLeft(3,'0')}', 
                    style: const TextStyle(color: Colors.black38)
                  ),
                ),
              ),

              Hero(
                tag: 'nombre_pokemon${pokemon.id}',
                flightShuttleBuilder: flightShuttleBuilder,
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text(
                    pokemon.getPokemonName(pokemon.name),
                    style: const TextStyle(
                      fontSize: 30, 
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis
                    )
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                height: 40,
                child: Hero(
                  flightShuttleBuilder: flightShuttleBuilder,
                  tag: 'badges_pokemon${pokemon.id}',
                  child: PokemonTypeBadges(badges: pokemon.getPokemonTypes(pokemon.types))
                ),
              ),

            ],
        
          ),

        )
      ],

    );
  }
}

class _PokemonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final AppBar appBar;
  const _PokemonAppBar({
    Key? key,
    required this.pokemon, required this.appBar,
  }) : super(key: key);

  final PokemonResponse pokemon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 10 ,
        backgroundColor: pokemon.color,
        centerTitle: true,
        title: const Text(
          'Pokemon',
          style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis
          )),
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height+10);
}