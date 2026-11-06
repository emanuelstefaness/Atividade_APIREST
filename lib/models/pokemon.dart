class Pokemon {
  final int id;
  final String name;
  final double height;
  final double weight;
  final List<String> types;
  final List<String> abilities;
  final String image;

  Pokemon({
    required this.id,
    required this.name,
    this.height = 0,
    this.weight = 0,
    this.types = const [],
    this.abilities = const [],
    required this.image,
  });

  // Usado na listagem: a API só devolve o nome e a url de cada pokémon.
  factory Pokemon.fromListJson(Map<String, dynamic> json) {
    final url = json['url'] as String;

    // A url termina com o id: .../pokemon/25/
    // Separamos pelas barras e pegamos o penúltimo pedaço.
    final parts = url.split('/');
    final id = int.parse(parts[parts.length - 2]);
    return Pokemon(
      id: id,
      name: json['name'],
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  // Usado no detalhe: aqui a API devolve todos os dados do pokémon.
  // A altura vem em decímetros e o peso em hectogramas,
  // por isso dividimos por 10 para ficar em metros e quilos.
  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'] / 10,
      weight: json['weight'] / 10,
      types: (json['types'] as List)
          .map((t) => t['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((a) => a['ability']['name'] as String)
          .toList(),
      image: json['sprites']['other']['official-artwork']['front_default'],
    );
  }

  @override
  bool operator ==(Object other) => other is Pokemon && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
