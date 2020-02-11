
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/enums/movie_source.dart';
import 'package:ytsm/models/movie.dart';
import 'package:ytsm/providers/search_movie_provider.dart';
import 'package:ytsm/widgets/drop_down_widget.dart';
import 'package:ytsm/widgets/movie_grid_item.dart';

class SearchPage extends StatefulWidget {
  final Key key;
  SearchPage(this.key) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchMovieProvider searchMovieProvider;
  final queryTermContriller = TextEditingController();
  bool _isLoading = false;
  void loadingIdecator() {
    if (_isLoading == false) {
      setState(() {
        _isLoading = true;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    searchMovieProvider = Provider.of<SearchMovieProvider>(context);
    return SafeArea(
      top: true,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: TextField(
                    controller: queryTermContriller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search for a Movie, Actor ...',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0, left: 5),
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FlatButton(
                      color: Colors.green,
                      child: Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        loadingIdecator();
                        searchMovieProvider
                            .searchMovie(queryTermContriller.text);
                      }),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 2,
              ),
              children: <Widget>[
                buildSearchType(
                    'Quality',
                    searchMovieProvider.filterQuality,
                    SearchMovieProvider.quality,
                    searchMovieProvider.setFilterQuality),
                buildSearchType(
                    'Rating',
                    searchMovieProvider.filterRating,
                    SearchMovieProvider.rate,
                    searchMovieProvider.setFilterRating),
                buildSearchType(
                    'Genre',
                    searchMovieProvider.filterGener,
                    SearchMovieProvider.genre,
                    searchMovieProvider.setFilterGener),
                buildSearchType(
                    'Sort By',
                    searchMovieProvider.filterOrderBy,
                    SearchMovieProvider.sortBy,
                    searchMovieProvider.setFilterOrderBy),
              ],
            ),
          ),
          buildStreamBuilder(),
        ],
      ),
    );
  }

  Widget buildStreamBuilder() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.61,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<List<Movie>>(
        stream: searchMovieProvider.moviesStream,
        builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text(
                'Failed to find what you want 😢',
                style: TextStyle(color: Colors.white),
              ),
            );
          if (snapshot.hasData) {
            return snapshot.data.length == 0
                ? Center(
                    child: Text(
                      'don\'t know that one',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : buildSearchMovieBody(snapshot);
          }
          return Center(
            child: Text(
              'Search for Specific Movie',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchMovieBody(AsyncSnapshot<List<Movie>> snapshot) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.79,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        shrinkWrap: true,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) =>
            MovieGridItem(snapshot.data[index], MovieSource.SearchPage),
      ),
    );
  }

  Widget buildSearchType(String text, String value, List<String> typeList,
      Function(String) onSelect) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.headline4,
          ),
          DropDownWidget(
            value: value,
            typeList: typeList,
            onSelect: onSelect,
          ),
        ],
      ),
    );
  }
}
