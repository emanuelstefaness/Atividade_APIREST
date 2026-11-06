import 'dart:convert';

import 'package:pokedex_turma/models/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> getPokemons({int limit = 40}) async {
    // Fazemos a requisição GET para a API.
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?limit=$limit'),
    );

    // Código 200 significa que deu tudo certo.
    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar a lista (${response.statusCode})');
    }

    // Transformamos o JSON (texto) em um Map do Dart.
    final data = jsonDecode(response.body);

    // A lista de pokémons fica dentro da chave "results".
    final results = data['results'] as List;
    return results.map((item) => Pokemon.fromListJson(item)).toList();
  }

  Future<Pokemon> getPokemonById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar o pokémon (${response.statusCode})');
    }

    return Pokemon.fromJson(jsonDecode(response.body));
  }

  Future<Pokemon> searchPokemon(String name) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon/${name.trim().toLowerCase()}'),
    );

    // 404 significa que não existe pokémon com esse nome.
    if (response.statusCode == 404) {
      throw Exception('Pokémon não encontrado');
    }
    if (response.statusCode != 200) {
      throw Exception('Erro na busca (${response.statusCode})');
    }

    return Pokemon.fromJson(jsonDecode(response.body));
  }
}
