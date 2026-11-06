# Pokédex

Aplicativo Flutter que consome uma API REST para listar pokémons, buscar pelo nome, ver detalhes e favoritar.

## API utilizada

- **Nome:** PokéAPI
- **Endereço base:** https://pokeapi.co/api/v2
- **Documentação:** https://pokeapi.co/docs/v2
- **Autenticação:** não precisa de chave

### Endpoints usados

| Método | Endereço | Uso |
| ------ | -------- | --- |
| GET | `/pokemon?limit=40` | Lista de pokémons |
| GET | `/pokemon/{id}` | Detalhes de um pokémon |
| GET | `/pokemon/{nome}` | Busca pelo nome |

## Estrutura

```
lib/
  models/      pokemon.dart
  services/    pokemon_service.dart   (requisições HTTP)
  providers/   favorites_provider.dart
  pages/       pokemon_page.dart, detail_page.dart, favorites_page.dart
```

## Como rodar

```
flutter pub get
flutter run
```

Pacotes: `http` e `provider`.

Repositório: https://github.com/emanuelstefaness/Atividade_APIREST
