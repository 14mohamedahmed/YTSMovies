import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ytsm/environment.dart';
import 'package:http/http.dart' as h;
import 'package:ytsm/models/movie.dart';

class SearchMovieProvider extends ChangeNotifier {
  List<Movie> _movies = [];
  List<Movie> get movies {
    return _movies;
  }

  Future<void> searchMovie(String queryTerm) async {
    final String url = Environment.moviesUrl + '?query_term=$queryTerm';
    h.Response response = await h.get(url);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['data']['movie_count'] < 1) return;
    _movies.clear();
    for (var movie in res['data']['movies']) {
      _movies.add(Movie.fromJson(movie));
    }
    print(_movies.length);
    notifyListeners();
  }
}
