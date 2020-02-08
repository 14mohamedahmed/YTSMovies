import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/enums/movie_source.dart';
import 'package:ytsm/models/movie.dart';
import '../widgets/movie_grid_item.dart';
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
        child: GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          shrinkWrap: true,
          itemCount: movies.length,
          itemBuilder: (context, index) =>
              MovieGridItem(movies[index], MovieSource.MoviesPage),
        ),
      ),
    );
  }
}
