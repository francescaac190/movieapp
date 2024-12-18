// To parse this JSON data, do
//
//     final nowPlaying = nowPlayingFromMap(jsonString);

import 'dart:convert';

import 'package:movieapp/models/models.dart';

NowPlaying nowPlayingFromMap(String str) =>
    NowPlaying.fromMap(json.decode(str));

String nowPlayingToMap(NowPlaying data) => json.encode(data.toMap());

class NowPlaying {
  Dates? dates;
  int? page;
  List<Result>? results;
  int? totalPages;
  int? totalResults;

  NowPlaying({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory NowPlaying.fromMap(Map<String, dynamic> json) => NowPlaying(
        dates: json["dates"] == null ? null : Dates.fromMap(json["dates"]),
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"]!.map((x) => Result.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "dates": dates?.toMap(),
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum:
            json["maximum"] == null ? null : DateTime.parse(json["maximum"]),
        minimum:
            json["minimum"] == null ? null : DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toMap() => {
        "maximum":
            "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
      };
}
