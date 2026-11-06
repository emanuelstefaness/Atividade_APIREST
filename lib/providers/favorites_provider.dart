import 'package:pokedex_turma/models/pokemon.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Pokemon> _items = [];

  List<Pokemon> get items => _items;

  bool isFavorite(Pokemon pokemon) {
    return _items.contains(pokemon);
  }

  void toggle(Pokemon pokemon) {
    if (_items.contains(pokemon)) {
      _items.remove(pokemon);
    } else {
      _items.add(pokemon);
    }
    notifyListeners();
  }
}
