import 'package:flutter/material.dart';
import 'package:ytsm/enums/movie_source.dart';
import 'package:ytsm/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/providers/search_movie_provider.dart';
import 'package:ytsm/providers/theme_provider.dart';
import 'package:ytsm/widgets/item_details.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/deatails-page';
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  var provider;
  @override
  //momocad
  Widget build(BuildContext context) {
    final moviesId = (ModalRoute.of(context).settings.arguments
        as Map<String, dynamic>)['id'];
    final MovieSource source = (ModalRoute.of(context).settings.arguments
        as Map<String, dynamic>)['source'];

    provider = source == MovieSource.MoviesPage
        ? Provider.of<MoviesProvider>(context)
        : Provider.of<SearchMovieProvider>(context);

    final filterdMovie = provider.fetchMovieDetailsById(moviesId);
   
    print(moviesId);
    print(filterdMovie.id);
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).getThemebackground,
      body: Container(child: ItemDetails(filterdMovie)),
    );
  }
}
