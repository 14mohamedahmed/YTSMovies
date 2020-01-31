import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ytsm/environment.dart';
import 'package:http/http.dart' as h;
import 'package:ytsm/models/movie.dart';

class SearchMovieProvider extends ChangeNotifier {
  List<Movie> _movie;
  List<Movie> get movie {
    return _movie;
  }

  Future<void> searchMovie(String queryTerm) async {
    final String url = Environment.moviesUrl+'query_term=$queryTerm';
    h.Response response = await h.get(url);
    final res = json.decode(response.body) as Map<String,dynamic>;
    _movie.add(Movie.fromJson(res));
    print(_movie);
    notifyListeners();
  }
}
