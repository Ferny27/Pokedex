import 'package:flutter/material.dart';

class PokemonTypeBadges extends StatelessWidget {
  final List<Widget> badges;

  const PokemonTypeBadges({super.key, required this.badges});

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