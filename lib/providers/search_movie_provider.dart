import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:ytsm/environment.dart';
import 'package:http/http.dart' as h;
import 'package:ytsm/models/movie.dart';

class SearchMovieProvider extends ChangeNotifier {
  BehaviorSubject<List<Movie>> _searchSubject = BehaviorSubject();
  Stream<List<Movie>> get moviesStream => _searchSubject.stream;
  String _filterQuality = quality[0];
  String _filterRating = rate[0];
  String _filterGener = genre[0];
  String _filterOrderBy = oderBy[0];

  String get filterQuality => _filterQuality;
  String get filterRating => _filterRating;
  String get filterGener => _filterGener;
  String get filterOrderBy => _filterOrderBy;

  setFilterQuality(String value)=>_filterQuality = value;
  setFilterRating(String value)=>_filterRating = value;
  setFilterGener(String value)=>_filterGener = value;
  setFilterOrderBy(String value)=>_filterOrderBy = value;

  Future<void> searchMovie(String queryTerm) async {
    final String url = Environment.moviesUrl +
        '?query_term=$queryTerm&quality=$_filterQuality&genre=$_filterGener';
        print('search url with filters: $url');
    h.Response response = await h.get(url);
    print(response.body);
    Map<String, dynamic> res = json.decode(response.body);
    if (res['data']['movie_count'] < 1) {
      _searchSubject.addError('We cannot find this movie');
      return;
    }
    _searchSubject.add(<Movie>[]);
    List<Movie> _movies = [];
    for (var movie in res['data']['movies']) {
      _movies.add(Movie.fromJson(movie));
    }
    _searchSubject.add(_movies);
    print(_movies.length);
  }

  Movie fetchMovieDetailsById(int id) {
    return _searchSubject.value.firstWhere((mov) => mov.id == id);
  }

  static const List<String> genre = const [
    'All',
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'Film-Noir',
    'Game-Show',
    'History',
    'Horror',
    'Music',
    'Musical',
    'Mystery',
    'News',
    'Reality-TV',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Talk-Show',
    'Thriller',
    'War',
    'Western'
  ];
  static const List<String> oderBy = const [
    'Latest',
    'Oldest',
    'Seeds',
    'Peers',
    'Year',
    'Rating',
    'Likes',
    'Alphabetical',
    'Downloads'
  ];
  static const List<String> quality = const ['All', '720p', '1080p', '3D'];
  static const List<String> rate = const [
    'All',
    '1+',
    '2+',
    '3+',
    '4+',
    '5+',
    '6+',
    '7+',
    '8+',
    '9+'
  ];
}
