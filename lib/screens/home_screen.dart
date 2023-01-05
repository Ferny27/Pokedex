import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    final pokemonProvider = Provider.of<PokemonProvider>(context, listen: true);
    final size = MediaQuery.of(context).size.height;

    return Scaffold(
      
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: const _Circles()
      ),

      body: pokemonProvider.pokemonTable.isEmpty 
      ? Container(
          width: double.infinity,
          height: size,
          alignment: Alignment.center, // where to position the child
          child: Container(
            width: 50.0,
            height: 50.0,
            child: const CircularProgressIndicator.adaptive() ,
          ),
        )
      :Container(
        padding: const EdgeInsets.symmetric( vertical: 0, horizontal: 10),
        width: double.infinity,
        child: _PokemonTable(pokemonProvider: pokemonProvider),
      ),

    );
  }
}

class _PokemonTable extends StatefulWidget {

  const _PokemonTable({
    Key? key,
    required this.pokemonProvider,
  }) : super(key: key);

  final PokemonProvider pokemonProvider;

  @override
  State<_PokemonTable> createState() => _PokemonTableState();
}

class _PokemonTableState extends State<_PokemonTable> {

  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() async {
      double position = scrollController.position.pixels;
      double max = scrollController.position.maxScrollExtent;
      if((position + 1000) >= max){
    
        if(isLoading) return;
        print(position);
        isLoading = true;
        setState(() {});

        await widget.pokemonProvider.getPokemon();
        
        isLoading = false;
        setState(() {});

        if(scrollController.position.pixels + 100 <= scrollController.position.maxScrollExtent) return;
        scrollController.animateTo(
          scrollController.position.pixels+120, 
          duration: const Duration (milliseconds: 300),
          curve: Curves.fastOutSlowIn
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[

        SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Image(
                height: 80,
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.contain
              ),
              Table(
                children: widget.pokemonProvider.pokemonTable 
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),

        if(isLoading) 
          _LoadingPokemon()
      ],
    );
  }
}

class _LoadingPokemon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right:0, 
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white
        ),
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image(
            image: AssetImage("assets/loading_data.gif"),
            fit: BoxFit.cover
          ),
        ),
      )
    );
  }
}

class _Circles extends StatelessWidget {
  const _Circles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _BlueCircle(),
          _SmallCircle( color: Color.fromARGB(255, 198, 40, 40)),
          _SmallCircle( color: Colors.yellow),
          _SmallCircle( color: Colors.green)
        ],
      ),
    );
  }
}

class _BlueCircle extends StatelessWidget {
  const _BlueCircle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: _blueCircleDecoration(),
    );
  }

  BoxDecoration _blueCircleDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: Colors.white,
        width: 5
      ),
      color: Colors.blue
    );
  }
}

class _SmallCircle extends StatelessWidget {
  final Color color;

  const _SmallCircle({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.5)
      ),
    );
  }
}