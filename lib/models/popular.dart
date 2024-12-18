// To parse this JSON data, do
//
//     final popular = popularFromMap(jsonString);

import 'dart:convert';

import 'package:movieapp/models/models.dart';

Popular popularFromMap(String str) => Popular.fromMap(json.decode(str));

String popularToMap(Popular data) => json.encode(data.toMap());

class Popular {
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  Popular({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory Popular.fromMap(Map<String, dynamic> json) => Popular(
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
