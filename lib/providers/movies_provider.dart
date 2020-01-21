import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as h;
import 'package:ytsm/environment.dart';
import 'package:ytsm/models/movie.dart';

class MoviesProvider with ChangeNotifier {
  BehaviorSubject<List<Movie>> _moviesSubject = BehaviorSubject();
  int _page = 1;

  Stream<List<Movie>> get moviesStream => _moviesSubject.stream;

  Future<dynamic> fetchMovies() async {
    if (_page > 25) return true;
    final String url = Environment.moviesUrl + '?limit=15&page=${_page++}';
    //   try {
    h.Response response = await h.get(url);
    Map<String, dynamic> res = json.decode(response.body);
    List<Movie> movies = _moviesSubject.hasValue ? _moviesSubject.value : [];
    for (var movie in res['data']['movies']) {
      movies.add(Movie.fromJson(movie));
    }
    _moviesSubject.add(movies);
    //  } catch (e) {
    //    _moviesSubject.addError(e.toString());
    //  }
  }
  Movie fetchMovieDetailsById(int id){
    // final String url = Environment.moviesUrl+'/data/movies/$id';
    // h.Response response = await h.get(url);
    // String movieId = json.decode(response.body);
    // if(movieId != id){
    //   return true;
    // }
  return _moviesSubject.value.firstWhere((mov)=>mov.id==id);
  }
}
