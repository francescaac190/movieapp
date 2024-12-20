import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/helpers/debouncer.dart';
import 'package:movieapp/models/credits.dart';
import 'package:movieapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _baseurl = 'api.themoviedb.org';
  String _apiKey = 'b1ac0289958eb27cc1a8959d77d405c1';
  String _language = 'es-ES';

  List<Result> onDisplayMovies = [];

  List<Result> onpoular = [];

  Map<int, List<Cast>> castlist = {};

  int popularpage = 0;
  final StreamController<List<Result>> _suggetionsStreamController =
      StreamController.broadcast();

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  Stream<List<Result>> get suggestionsStream =>
      _suggetionsStreamController.stream;

  MoviesProvider() {
    this.getOnDisplayMovies();
    this.getPopular();
  }
  Future<String> _getJsonData(String endpoint, String page) async {
    var url = Uri.https(_baseurl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': page});

    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing', '1');

    final nowplayingresponse = NowPlaying.fromMap(jsonDecode(jsonData)).results;
    onDisplayMovies = nowplayingresponse!;

    notifyListeners();
  }

  getPopular() async {
    popularpage++;
    final jsonData =
        await _getJsonData('3/movie/popular', popularpage.toString());

    final popularresponse = Popular.fromMap(jsonDecode(jsonData)).results;
    onpoular = [...onpoular, ...popularresponse!];

    notifyListeners();
  }

  Future<List<Cast>> getCast(int id) async {
    if (castlist.containsKey(id)) {
      return castlist[id]!;
    }

    final jsonData =
        await _getJsonData('3/movie/$id/credits', popularpage.toString());

    final castresponse = Credits.fromMap(jsonDecode(jsonData)).cast;
    castlist[id] = castresponse!;

    return castresponse;
  }

  Future<List<Result>> searchmovie(String query) async {
    var url = Uri.https(_baseurl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);

    final searchresponse = Search.fromMap(jsonDecode(response.body)).results;

    return searchresponse!;
  }

  void getSuggetionsByQuery(String searchTerm) {
    debouncer.value = searchTerm;

    debouncer.onValue = (value) async {
      final results = await searchmovie(value.toString());
      _suggetionsStreamController.add(results);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
