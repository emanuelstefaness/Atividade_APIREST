import 'package:pokedex_turma/models/pokemon.dart';
import 'package:pokedex_turma/providers/favorites_provider.dart';
import 'package:pokedex_turma/services/pokemon_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PokemonService service = PokemonService();
  late Future<Pokemon> pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = service.getPokemonById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(
      future: pokemon,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: Text("Detalhes")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Detalhes")),
            body: Center(child: Text("Erro ao carregar o pokémon.")),
          );
        }

        final item = snapshot.data!;
        final isFav = context.watch<FavoritesProvider>().isFavorite(item);

        return Scaffold(
          appBar: AppBar(
            title: Text(item.name.toUpperCase()),
            actions: [
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : null,
                ),
                onPressed: () {
                  Provider.of<FavoritesProvider>(
                    context,
                    listen: false,
                  ).toggle(item);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Image.network(item.image, height: 220),
                  SizedBox(height: 16),
                  Text("Número: ${item.id}"),
                  Text("Tipo: ${item.types.join(", ")}"),
                  Text("Altura: ${item.height} m"),
                  Text("Peso: ${item.weight} kg"),
                  Text("Habilidades: ${item.abilities.join(", ")}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
