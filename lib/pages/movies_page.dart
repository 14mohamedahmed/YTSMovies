import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/models/movie.dart';
import 'package:ytsm/pages/details_page.dart';
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
      child: GridView.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: GridTile(
              header: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 35,
                      ),
                      Text(
                        movies[index].rating,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              footer: Container(
                height: 30,
                alignment: Alignment.center,
                color: Colors.black54,
                child: Text(
                  movies[index].title +' '+ movies[index].year.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              child: GestureDetector(
                onTap: () => {
                  Navigator.of(context).pushNamed(DetailsPage.routeName,arguments: movies[index].id)
                },
                child: Hero(
                  tag: movies[index].id,
                  child: Image.network(
                    movies[index].largeCoverImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          // child: Card(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(15.0),
          //   ),
          //   elevation: 2,
          //   color: Colors.white,
          //   child: Column(
          //     children: <Widget>[

          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
