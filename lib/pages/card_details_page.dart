import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/providers/movies_provider.dart';
import 'package:ytsm/providers/theme_provider.dart';
import 'package:ytsm/widgets/movie_details.dart';

class CardDetailsPage extends StatefulWidget {
  static final String routeName = '/cardDetailsPage';
  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final movieId = ModalRoute.of(context).settings.arguments;
    final filterMovie= Provider.of<MoviesProvider>(context).fetchMovieDetailsById(movieId);
    print(movieId);
    print(filterMovie.id);
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).getThemebackground,
      body: MovieDetails(filterMovie),
    );
  }
}
