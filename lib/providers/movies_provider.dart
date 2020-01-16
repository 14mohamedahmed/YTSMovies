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
    print('request started');
    h.Response response = await h.get(url);
    print('request done');
    Map<String, dynamic> res = json.decode(response.body);
    print('request decoded');
    List<Movie> movies = _moviesSubject.hasValue ? _moviesSubject.value : [];
    print('placeholder init');
    for (var movie in res['data']['movies']) {
      movies.add(Movie.fromJson(movie));
    }
    print(movies.length);
    _moviesSubject.add(movies);
    //  } catch (e) {
    //    _moviesSubject.addError(e.toString());
    //  }
  }
}
