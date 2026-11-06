import 'package:pokedex_turma/pages/pokemon_page.dart';
import 'package:pokedex_turma/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoritesProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      debugShowCheckedModeBanner: false,
      home: PokemonPage(),
    );
  }
}
