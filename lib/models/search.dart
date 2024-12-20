// To parse this JSON data, do
//
//     final search = searchFromMap(jsonString);

import 'dart:convert';

import 'package:movieapp/models/models.dart';

Search searchFromMap(String str) => Search.fromMap(json.decode(str));

String searchToMap(Search data) => json.encode(data.toMap());

class Search {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  Search({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Search.fromMap(Map<String, dynamic> json) => Search(
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"]!.map((x) => Result.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
