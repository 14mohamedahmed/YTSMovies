import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/models/movie.dart';
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


// TODO replace this ListTile with your design
  Widget buildMoviesBody(List<Movie> movies) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: movies.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(movies[index].title),
      ),
    );
  }
}
