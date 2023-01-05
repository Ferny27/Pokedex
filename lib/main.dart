import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pokedex/providers/providers.dart';
import 'package:pokedex/screens/screens.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (BuildContext context) => PokemonProvider(),
    lazy: true,
    child: const MyApp()
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        "home":(context) => const HomeScreen(),
        "pokemon":(context) => const PokemonScreen()
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color: Colors.red,
          toolbarHeight: 75
        ),
        scaffoldBackgroundColor: Colors.grey[100]
      ),
    );
  }
}