import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ytsm/environment.dart';
import 'package:http/http.dart' as h;
import 'package:ytsm/models/movie.dart';

class SearchMovieProvider extends ChangeNotifier {
  BehaviorSubject<List<Movie>> _searchSubject = BehaviorSubject();
  Stream<List<Movie>> get moviesStream => _searchSubject.stream;

  Future<void> searchMovie(String queryTerm) async {
    final String url = Environment.moviesUrl + '?query_term=$queryTerm';
    h.Response response = await h.get(url);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['data']['movie_count'] < 1) return;
    _searchSubject.add(<Movie>[]);
    List<Movie> _movies = [];
    for (var movie in res['data']['movies']) {
      _movies.add(Movie.fromJson(movie));
    }
    _searchSubject.add(_movies);
    print(_movies.length);
  }
  Movie fetchMovieDetailsById(int id){
  return _searchSubject.value.firstWhere((mov)=>mov.id==id);
  }
}
