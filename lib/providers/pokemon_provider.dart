import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/models.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokemonProvider extends ChangeNotifier {
  
  final String _baseUrl ='pokeapi.co';
  int offset = 0;
  List<TableRow> pokemonTable = [];
  List<Widget> pokemonRow=[];

  PokemonProvider(){
    getPokemon();
  }

  Future getPokemon () async{
    //print(offset);
    //Obtenemos los pokemon de cada pagina en grupos de 20
    var url = Uri.https(_baseUrl, 'api/v2/pokemon/',{
      "limit": "20",
      "offset": offset.toString(),
    });

    final response = await http.get(url);

    //Recibimos la información de la paginación de los pokemon de acuerdo a los parámetros enviados
    final page = PaginationResponse.fromJson(response.body);

    //print(page.results); // Me imprime una lista de instancias de mi clase PoekmonPath
    //page.results.map((e) => print(e.toJson())); //Convierto cada instancia de PokemonPath a un Json

    //Obtenemos la información de cada pokemón de la página
    int column =0;
    for(PokemonPath pokemon in page.results){
      //print(pokemon.url);
      url = Uri.https(_baseUrl, 'api/v2/pokemon/${pokemon.name}',);
      final data = await http.get(url);

      final pokemonData = PokemonResponse.fromJson(data.body);

      //Generar la card de cada pokemon
      pokemonData.color = pokemonData.getPokemonColor(pokemonData.types[0].type.name);
      pokemonRow.add( PokemonCard(pokemon: pokemonData) );
      column++;

      //Crear cada fila de la tabla con 2 cards
      if(column==2){
        pokemonTable.add(TableRow(children: pokemonRow));
        pokemonRow=[];
        column=0;
      }
    }
    offset += 20;
    notifyListeners();
  }
}