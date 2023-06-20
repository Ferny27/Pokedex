import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokedex/models/models.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
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
      
          _PokemonInfo(pokemon: pokemon),

          _PokemonDescription( pokemon.id.toString() ),

          _PokemonChars( pokemon ),

          FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 150)),
            builder: ((context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return _PokemonStats( pokemon );
              }
          
              return  Container();
              
            })
          )
      
        ]),
      ),
    );
  }
}

class _PokemonStats extends StatelessWidget {

  final PokemonResponse pokemon;

  const _PokemonStats(this.pokemon);

  @override
  Widget build(BuildContext context) {

    final List<Stat> pokemonStats = pokemon.stats;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric( vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Stats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const SizedBox( height: 10),
          for (var statIndex in pokemonStats) 
          _Stat(
            label: pokemon.getPokemonName(statIndex.stat.name), 
            value: statIndex.baseStat,
            rate: pokemon.getStatRate(statIndex.baseStat),
            color: pokemon.color!,
          ),

        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final int value;
  final double rate;
  final Color color;

  const _Stat(
    {
      super.key, 
      required this.label, 
      required this.value, 
      required this.rate, 
      required this.color
    }
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        final lineWidth = constraints.maxWidth * rate;

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: double.infinity,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),

              Stack(
                children: [

                  Container(
                    width: constraints.maxWidth,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only( topRight: Radius.circular(10), bottomRight: Radius.circular(10))
                    ),
                  ),

                  _StatBarAnimation(lineWidth: lineWidth, color: color, value: value)
                ],
              )

            ],
          )
        );
      }
    );
  }
}

class _StatBarAnimation extends StatefulWidget {
  const _StatBarAnimation({
    Key? key,
    required this.lineWidth,
    required this.color,
    required this.value,
  }) : super(key: key);

  final double lineWidth;
  final Color color;
  final int value;

  @override
  State<_StatBarAnimation> createState() => _StatBarAnimationState();
}

class _StatBarAnimationState extends State<_StatBarAnimation> with TickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _width;

  @override
  void initState(){
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this,
    );

    _width = Tween(begin: 0.0, end: widget.lineWidth).animate(_controller);

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller, 
      builder: _buildAnimatedStat
    );
  }

  Widget _buildAnimatedStat(BuildContext context, Widget? child) {
    return Container(
      width:_width.value,
      height: 20,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.5),
        borderRadius: const BorderRadius.only( topRight: Radius.circular(10), bottomRight: Radius.circular(10))
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          widget.value.toString(), 
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _PokemonDescription extends StatelessWidget {

  final String id;

  const _PokemonDescription(this.id,);

  @override
  Widget build(BuildContext context) {

    final PokemonProvider pokemonProvider = Provider.of<PokemonProvider>(context);

    return FutureBuilder(
      future: pokemonProvider.getSpecieInfo(id),
      builder: ((context, snapshot) {
        if(snapshot.connectionState != ConnectionState.done){
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 15),
            height: 20,
            width: 20,
            child: const CircularProgressIndicator(),
          );
        }
        //return Container(
        //  height: 50,
        //  width: 50,
        //  color: Colors.blue,
        //);
        return Container(
          margin: const EdgeInsets.symmetric( vertical: 15),
          child: Text(
            snapshot.data!,
            style: const TextStyle(color: Colors.black45, fontSize: 15),
            textAlign: TextAlign.justify,
          )
        );
      })
    );

  }
}

class _PokemonChars extends StatelessWidget {

  final PokemonResponse pokemon;
  
  const _PokemonChars( this.pokemon );

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Row(

        children: [

          _newChar('Height', "${pokemon.realheight}''"),

          _newChar('Weight', "${pokemon.realweight} lb"),

          _newChar('Base \nExperience', pokemon.baseExperience.toString()),
          
        ],

      )

    );
  }

  Expanded _newChar( String label, String value) {
    return Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.all( Radius.circular(10))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(value, 
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), 
                        textAlign: TextAlign.center
                      ),
                    )
                  )
                ),
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: Text(label.toUpperCase(), 
                      style: const TextStyle(color: Colors.black45, fontSize: 15, letterSpacing: 2.5), 
                      textAlign: TextAlign.center,
                    )
                  ),
                ),
              ],
            )
          )
        );
  }
}

class _PokemonInfo extends StatefulWidget {
  const _PokemonInfo({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final PokemonResponse pokemon;

  @override
  State<_PokemonInfo> createState() => _PokemonInfoState();
}

class _PokemonInfoState extends State<_PokemonInfo> {
  @override
  Widget build(BuildContext context) {

    String pokemonImage ;

    switch (widget.pokemon.gender) {
      case 'shiny':
        pokemonImage = widget.pokemon.sprites.frontShiny;
        break;
      case 'female':
        pokemonImage = widget.pokemon.sprites.frontFemale;
        break;
      default:
        pokemonImage = widget.pokemon.sprites.frontDefault;
    }

    return Row(

      children: [

        Container(
          width: 120,
          height: 120,
          child: Hero(
            tag: 'imagen_pokemon${widget.pokemon.id}',
            child: Image(
              image: NetworkImage(pokemonImage),
              fit:BoxFit.cover
            ),
          ),
        ),

        const SizedBox(width: 10,),

        Expanded(

          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Hero(
                    tag: 'id_pokemon${widget.pokemon.id}',
                    flightShuttleBuilder: flightShuttleBuilder,
                    child: Container(
                      child: Text(
                        'N.° ${widget.pokemon.id.toString().padLeft(3,'0')}', 
                        style: const TextStyle(color: Colors.black38)
                      ),
                    ),
                  ),

                  Row(
                    children: [

                      _PokemonGenderSelector(
                        icon: Icons.male,
                        color: Colors.black54, 
                        activeColor: Colors.blue, 
                        compareTo: 'male', 
                        selectedOption: widget.pokemon.gender!,
                        onTapFunction: (){
                          widget.pokemon.gender = 'male';
                          setState((){});
                        },
                      ),

                      if(widget.pokemon.sprites.frontFemale != null)
                      _PokemonGenderSelector(
                        icon: Icons.female,
                        color: Colors.black54, 
                        activeColor: Colors.pink, 
                        compareTo: 'female', 
                        selectedOption: widget.pokemon.gender!,
                        onTapFunction: (){
                          widget.pokemon.gender = 'female';
                          setState((){});
                        },
                      ),

                      _PokemonGenderSelector(
                        icon: Icons.star,
                        color: Colors.black54, 
                        activeColor: Colors.amber, 
                        compareTo: 'shiny', 
                        selectedOption: widget.pokemon.gender!,
                        onTapFunction: (){
                          widget.pokemon.gender = 'shiny';
                          setState((){});
                        },
                      ),
                      
                    ],
                  ),

                ],
              ),

              Hero(
                tag: 'nombre_pokemon${widget.pokemon.id}',
                flightShuttleBuilder: flightShuttleBuilder,
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text(
                    widget.pokemon.getPokemonName(widget.pokemon.name),
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
                  tag: 'badges_pokemon${widget.pokemon.id}',
                  child: PokemonTypeBadges(badges: widget.pokemon.getPokemonTypes(widget.pokemon.types))
                ),
              ),

            ],
        
          ),

        )
      ],

    );
  }
}

class _PokemonGenderSelector extends StatelessWidget{
  final Function()? onTapFunction;
  final IconData icon;
  final Color activeColor;
  final Color color;
  final String compareTo;
  final String selectedOption;

  const _PokemonGenderSelector({
    super.key, 
    required this.activeColor, 
    required this.color, 
    required this.compareTo, 
    required this.selectedOption, 
    required this.icon, 
    required this.onTapFunction
  });

  @override
  Widget build(BuildContext context) {

    final Color iconColor = (compareTo == selectedOption ? activeColor : color);
    return GestureDetector(
      onTap: onTapFunction, 
      child: Container(
        margin:EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.topCenter,
        width: 30,
        height: 30,
        child: Icon(icon, size: 30, color: iconColor)
      )
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
        elevation: 5 ,
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