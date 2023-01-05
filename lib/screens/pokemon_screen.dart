import 'package:flutter/material.dart';

class PokemonScreen extends StatelessWidget {
   
  const PokemonScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
         child: Text('PokemonScreen'),
      ),
    );
  }
}