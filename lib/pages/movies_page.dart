import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/models/movie.dart';
import 'package:ytsm/widgets/movie_card_horizontal.dart';
import 'package:ytsm/widgets/movie_card_vertical.dart';
import 'package:ytsm/providers/movies_provider.dart';

class MoviesPage extends StatefulWidget {
  final Key key;

  MoviesPage(this.key) : super(key: key);

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  MoviesProvider moviesProvider;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent)
        moviesProvider.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    moviesProvider = Provider.of<MoviesProvider>(context);
    moviesProvider.fetchMovies();

    return StreamBuilder<List<Movie>>(
      stream: moviesProvider.moviesStream,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));

        return snapshot.hasData
            ? buildMoviesBody(snapshot.data)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildMoviesBody(List<Movie> movies) {
    return SafeArea(
      top: true,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 15.0, bottom: 8, left: 15.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Suggessions',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.345,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) =>
                    MovieCardHorizontal(movies[index]),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15.0, bottom: 8, left: 15.0),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Movies',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: movies.length,
              itemBuilder: (context, index) => MovieCardVetical(movies[index]),
            ),
          ],
        ),
      ),
    );
  }
}
