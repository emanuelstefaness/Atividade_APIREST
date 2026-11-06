import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_turma/models/pokemon.dart';

void main() {
  test('Pokemon.fromListJson extrai o id da url', () {
    final p = Pokemon.fromListJson({
      'name': 'pikachu',
      'url': 'https://pokeapi.co/api/v2/pokemon/25/',
    });
    expect(p.id, 25);
    expect(p.name, 'pikachu');
  });
}
