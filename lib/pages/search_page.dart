import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/providers/search_movie_provider.dart';

class SearchPage extends StatefulWidget {
  final Key key;
  SearchPage(this.key) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchMovieProvider searchMovieProvider;
  final queryTermContriller = TextEditingController();
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
                width: 260,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: TextField(
                    controller: queryTermContriller,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search for a Moviee...',
                      hintStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: 8.0, top: 8.0, bottom: 8.0, left: 0.5),
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
                      searchMovieProvider.searchMovie(queryTermContriller.text);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
