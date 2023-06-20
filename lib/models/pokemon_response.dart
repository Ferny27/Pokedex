// To parse this JSON data, do
//
//     final pokemonResponse = pokemonResponseFromMap(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

// Pokemon Information : Sprites, height, weight, base exp, stats

class PokemonResponse{
    PokemonResponse({
      required this.baseExperience,
      required this.forms,
      required this.height,
      required this.id,
      required this.name,
      required this.species,
      required this.sprites,
      required this.stats,
      required this.types,
      required this.weight,
    });

    int baseExperience;
    List<Species> forms;
    int height;
    int id;
    String name;
    Species species;
    Sprites sprites;
    List<Stat> stats;
    List<Type> types;
    int weight;
    Color? color;
    String? gender = 'male';

    factory PokemonResponse.fromJson(String str) => PokemonResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonResponse.fromMap(Map<String, dynamic> json) => PokemonResponse(
        baseExperience: json["base_experience"],
        forms: List<Species>.from(json["forms"].map((x) => Species.fromMap(x))),
        height: json["height"],
        id: json["id"],
        name: json["name"],
        species: Species.fromMap(json["species"]),
        sprites: Sprites.fromMap(json["sprites"]),
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromMap(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        weight: json["weight"],
    );

    Map<String, dynamic> toMap() => {
        "base_experience": baseExperience,
        "forms": List<dynamic>.from(forms.map((x) => x.toMap())),
        "height": height,
        "id": id,
        "name": name,
        "species": species.toMap(),
        "sprites": sprites.toMap(),
        "stats": List<dynamic>.from(stats.map((x) => x.toMap())),
        "types": List<dynamic>.from(types.map((x) => x.toMap())),
        "weight": weight,
    };
  
    String getPokemonName(String name){
      return "${name[0].toUpperCase()}${name.substring(1).toLowerCase()}";
    }

    String get realheight{
      return (height * 3.93).toStringAsFixed(2);
    }

    String get realweight{
      return (weight * 0.22).toStringAsFixed(2);
    }

    double getStatRate(int statVal){
      double rate = double.parse((statVal/255).toStringAsFixed(2));
      return rate;
    }

    List<Widget> getPokemonTypes(List<Type> types){

      final List<Widget> badges = [];
      Color color;

      for(Type type in types){
        color = getPokemonColor(type.type.name);
        badges.add(Container(
                margin: const EdgeInsets.only(right: 8),
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color, width:2),
                  color: Colors.white.withOpacity(0.65)
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    getPokemonName(type.type.name), 
                    textAlign: TextAlign.center, 
                    style: TextStyle(color: color)
                    )
                ),
              ));
      }

      if(types.length<=1) badges.add(Container());

      return badges;
    }

    Color getPokemonColor(String selector){
      Color color;
      switch (selector) {
          case 'bug':
            color = Colors.lightGreen;
            break;
          case 'dark':
            color = Colors.black87;
            break;
          case 'dragon':
            color = Colors.indigo.shade400;
            break;
          case 'electric':
            color = Colors.amber.shade400;
            break;
          case 'fairy':
            color = Colors.pink.shade200;
            break;
          case 'fighting':
            color = Colors.brown.shade700;
            break;
          case 'fire':
            color = Colors.deepOrange;
            break;
          case 'flying':
            color = Colors.blue.shade200;
            break;
          case 'ghost':
            color = Colors.deepPurple;
            break;
          case 'grass':
            color = Colors.green;
            break;
          case 'ground':
            color = Colors.brown;
            break;
          case 'ice':
            color = Colors.lightBlue.shade200;
            break;
          case 'poison':
            color = Colors.purple.shade700;
            break;
          case 'psychic':
            color = Colors.pinkAccent;
            break;
          case 'rock':
            color = Colors.brown.shade300;
            break;
          case 'steel':
            color = Colors.grey.shade700;
            break;
          case 'water':
            color = Colors.blue.shade800;
            break;
          default:
            color=Colors.grey;
        }

      return color;
    }
}

class Species {
    Species({
      required this.name,
      required this.url,
    });

    String name;
    String url;

    factory Species.fromJson(String str) => Species.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Species.fromMap(Map<String, dynamic> json) => Species(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
    };
}

class Sprites {
    Sprites({
      required this.backDefault,
      required this.backFemale,
      required this.backShiny,
      required this.backShinyFemale,
      required this.frontDefault,
      required this.frontFemale,
      required this.frontShiny,
      required this.frontShinyFemale,
    });

    String backDefault;
    dynamic backFemale;
    String backShiny;
    dynamic backShinyFemale;
    String frontDefault;
    dynamic frontFemale;
    String frontShiny;
    dynamic frontShinyFemale;

    factory Sprites.fromJson(String str) => Sprites.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Sprites.fromMap(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        backFemale: json["back_female"],
        backShiny: json["back_shiny"],
        backShinyFemale: json["back_shiny_female"],
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
    );

    Map<String, dynamic> toMap() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
    };
}

class Other {
    Other({
      required this.dreamWorld,
      required this.home,
      required this.officialArtwork,
    });

    DreamWorld dreamWorld;
    Home home;
    OfficialArtwork officialArtwork;

    factory Other.fromJson(String str) => Other.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Other.fromMap(Map<String, dynamic> json) => Other(
        dreamWorld: DreamWorld.fromMap(json["dream_world"]),
        home: Home.fromMap(json["home"]),
        officialArtwork: OfficialArtwork.fromMap(json["official-artwork"]),
    );

    Map<String, dynamic> toMap() => {
        "dream_world": dreamWorld.toMap(),
        "home": home.toMap(),
        "official-artwork": officialArtwork.toMap(),
    };
}

class DreamWorld {
    DreamWorld({
      required this.frontDefault,
      required this.frontFemale,
    });

    String frontDefault;
    dynamic frontFemale;

    factory DreamWorld.fromJson(String str) => DreamWorld.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DreamWorld.fromMap(Map<String, dynamic> json) => DreamWorld(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
    );

    Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
    };
}

class Home {
    Home({
      required this.frontDefault,
      required this.frontFemale,
      required this.frontShiny,
      required this.frontShinyFemale,
    });

    String frontDefault;
    dynamic frontFemale;
    String frontShiny;
    dynamic frontShinyFemale;

    factory Home.fromJson(String str) => Home.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Home.fromMap(Map<String, dynamic> json) => Home(
        frontDefault: json["front_default"],
        frontFemale: json["front_female"],
        frontShiny: json["front_shiny"],
        frontShinyFemale: json["front_shiny_female"],
    );

    Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
    };
}

class OfficialArtwork {
    OfficialArtwork({
      required this.frontDefault,
    });

    String frontDefault;

    factory OfficialArtwork.fromJson(String str) => OfficialArtwork.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OfficialArtwork.fromMap(Map<String, dynamic> json) => OfficialArtwork(
        frontDefault: json["front_default"],
    );

    Map<String, dynamic> toMap() => {
        "front_default": frontDefault,
    };
}

class Stat {
    Stat({
      required this.baseStat,
      required this.effort,
      required this.stat,
    });

    int baseStat;
    int effort;
    Species stat;

    factory Stat.fromJson(String str) => Stat.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Stat.fromMap(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: Species.fromMap(json["stat"]),
    );

    Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toMap(),
    };
}

class Type {
    Type({
      required this.slot,
      required this.type,
    });

    int slot;
    Species type;

    factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: Species.fromMap(json["type"]),
    );

    Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type.toMap(),
    };
}

// Pokemon Specie Information : Evolutions, flavor text (description), habitat, varieties

class PokemonSpecie {
    PokemonSpecie({
        required this.evolutionChain,
        this.evolvesFromSpecies,
        required this.flavorTextEntries,
        required this.habitat,
        required this.varieties,
    });

    EvolutionChain evolutionChain;
    EvolvesFromSpecies? evolvesFromSpecies;
    List<FlavorTextEntry> flavorTextEntries;
    EvolvesFromSpecies habitat;
    List<Variety> varieties;

    factory PokemonSpecie.fromJson(String str) => PokemonSpecie.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonSpecie.fromMap(Map<String, dynamic> json) => PokemonSpecie(
        evolutionChain: EvolutionChain.fromMap(json["evolution_chain"]),
        evolvesFromSpecies:EvolvesFromSpecies.fromMap(json["evolves_from_species"] ?? {}),
        flavorTextEntries: List<FlavorTextEntry>.from(json["flavor_text_entries"].map((x) => FlavorTextEntry.fromMap(x))),
        habitat: EvolvesFromSpecies.fromMap(json["habitat"]),
        varieties: List<Variety>.from(json["varieties"].map((x) => Variety.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "evolution_chain": evolutionChain.toMap(),
        "evolves_from_species": evolvesFromSpecies?.toMap(),
        "flavor_text_entries": List<dynamic>.from(flavorTextEntries.map((x) => x.toMap())),
        "habitat": habitat.toMap(),
        "varieties": List<dynamic>.from(varieties.map((x) => x.toMap())),
    };
}

class EvolutionChain {
    EvolutionChain({
        required this.url,
    });

    String url;

    factory EvolutionChain.fromJson(String str) => EvolutionChain.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EvolutionChain.fromMap(Map<String, dynamic> json) => EvolutionChain(
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "url": url,
    };
}

class EvolvesFromSpecies {
    EvolvesFromSpecies({
        this.name,
        this.url,
    });

    String? name;
    String? url;

    factory EvolvesFromSpecies.fromJson(String str) => EvolvesFromSpecies.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EvolvesFromSpecies.fromMap(Map<String, dynamic> json) => EvolvesFromSpecies(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
    };
}

class FlavorTextEntry {
    FlavorTextEntry({
        required this.flavorText,
        required this.language,
        required this.version,
    });

    String flavorText;
    EvolvesFromSpecies language;
    EvolvesFromSpecies version;

    factory FlavorTextEntry.fromJson(String str) => FlavorTextEntry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory FlavorTextEntry.fromMap(Map<String, dynamic> json) => FlavorTextEntry(
        flavorText: json["flavor_text"],
        language: EvolvesFromSpecies.fromMap(json["language"]),
        version: EvolvesFromSpecies.fromMap(json["version"]),
    );

    Map<String, dynamic> toMap() => {
        "flavor_text": flavorText,
        "language": language.toMap(),
        "version": version.toMap(),
    };
}

class Variety {
    Variety({
        required this.isDefault,
        required this.pokemon,
    });

    bool isDefault;
    EvolvesFromSpecies pokemon;

    factory Variety.fromJson(String str) => Variety.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Variety.fromMap(Map<String, dynamic> json) => Variety(
        isDefault: json["is_default"],
        pokemon: EvolvesFromSpecies.fromMap(json["pokemon"]),
    );

    Map<String, dynamic> toMap() => {
        "is_default": isDefault,
        "pokemon": pokemon.toMap(),
    };
}

