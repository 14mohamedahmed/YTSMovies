import 'package:flutter/material.dart';
import 'package:ytsm/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/providers/search_movie_provider.dart';
import 'package:ytsm/widgets/item_details.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/deatails-page';
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MoviesProvider moviesProvider;
  SearchMovieProvider searchMovieProvider;
  @override
  Widget build(BuildContext context) {
    final moviesId = ModalRoute.of(context).settings.arguments;
    moviesProvider = Provider.of<MoviesProvider>(context);
    searchMovieProvider = Provider.of<SearchMovieProvider>(context);
    final filterdMovie = moviesProvider.fetchMovieDetailsById(moviesId);
    final filterdSearchedMovie =
        searchMovieProvider.fetchMovieDetailsById(moviesId);
    print(moviesId);
    print(filterdMovie.id);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: ItemDetails(filterdMovie),
      // TODO here
    );
  }
}
