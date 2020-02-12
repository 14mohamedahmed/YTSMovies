import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/models/movie.dart';
import 'package:ytsm/providers/theme_provider.dart';
import 'package:ytsm/widgets/rate_star.dart';

class MovieCardHorizontal extends StatefulWidget {
  final Movie movie;
  MovieCardHorizontal(this.movie);
  @override
  _MovieCardHorizontalState createState() => _MovieCardHorizontalState();
}

class _MovieCardHorizontalState extends State<MovieCardHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width * 0.51,
      child: Card(
        color: Provider.of<ThemeProvider>(context).getCardItemColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15.0),
        ),
        elevation: 5,
        child: Stack(
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  widget.movie.mediumCoverImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RateStar(widget.movie.rating),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
