import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final paginationResponse = paginationResponseFromMap(jsonString);

import 'dart:convert';

class PaginationResponse {
    PaginationResponse({
      required this.count,
      required this.next,
      this.previous,
      required this.results,
    });

    int count;
    String next;
    dynamic? previous;
    List<PokemonPath> results;

    //Crea instancias del objeto con base a un json que viene como string
    factory PaginationResponse.fromJson(String str) => PaginationResponse.fromMap(json.decode(str));

    factory PaginationResponse.fromMap(Map<String, dynamic> json) => PaginationResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<PokemonPath>.from(json["results"].map((x) => PokemonPath.fromMap(x))),
    );

    //Crea un json con base a un mapa
    String toJson() => json.encode(toMap());

    Map<String, dynamic> toMap() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
    };
}

class PokemonPath {
    PokemonPath({
      required this.name,
      required this.url,
    });

    String name;
    String url;

    factory PokemonPath.fromJson(String str) => PokemonPath.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PokemonPath.fromMap(Map<String, dynamic> json) => PokemonPath(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
    };
}
