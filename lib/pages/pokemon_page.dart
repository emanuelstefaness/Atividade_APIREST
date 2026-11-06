import 'package:pokedex_turma/models/pokemon.dart';
import 'package:pokedex_turma/pages/favorites_page.dart';
import 'package:pokedex_turma/pages/detail_page.dart';
import 'package:pokedex_turma/providers/favorites_provider.dart';
import 'package:pokedex_turma/services/pokemon_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final PokemonService service = PokemonService();
  final TextEditingController searchController = TextEditingController();
  late Future<List<Pokemon>> pokemons;

  @override
  void initState() {
    super.initState();
    pokemons = service.getPokemons();
  }

  Future<void> search() async {
    // Pegamos o texto digitado.
    final name = searchController.text;

    // Se não digitou nada, não buscamos.
    if (name.trim().isEmpty) return;

    try {
      final pokemon = await service.searchPokemon(name);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(id: pokemon.id)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokédex"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              onSubmitted: (_) => search(),
              decoration: InputDecoration(
                hintText: "Buscar pelo nome (ex: pikachu)",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Pokemon>>(
              future: pokemons,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Não foi possível carregar os dados."),
                        SizedBox(height: 8),
                        ElevatedButton(
                          child: Text("Tentar novamente"),
                          onPressed: () {
                            setState(() {
                              pokemons = service.getPokemons();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }

                final list = snapshot.data!;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final pokemon = list[index];
                    final isFav = context
                        .watch<FavoritesProvider>()
                        .isFavorite(pokemon);
                    return ListTile(
                      leading: Image.network(pokemon.image, width: 56),
                      title: Text(
                        "#${pokemon.id} ${pokemon.name.toUpperCase()}",
                      ),
                      trailing: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : null,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(id: pokemon.id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
