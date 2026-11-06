import 'package:pokedex_turma/pages/detail_page.dart';
import 'package:pokedex_turma/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Favoritos")),
      body: favorites.items.isEmpty
          ? Center(child: Text("Nenhum pokémon favoritado"))
          : ListView.builder(
              itemCount: favorites.items.length,
              itemBuilder: (context, index) {
                final pokemon = favorites.items[index];
                return ListTile(
                  leading: Image.network(pokemon.image, width: 56),
                  title: Text(pokemon.name.toUpperCase()),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Provider.of<FavoritesProvider>(
                        context,
                        listen: false,
                      ).toggle(pokemon);
                    },
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
            ),
    );
  }
}
