import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/models/movie.dart';
import 'package:ytsm/pages/card_details_page.dart';
import 'package:ytsm/providers/theme_provider.dart';
import 'package:ytsm/widgets/rate_star.dart';

class MovieCardVetical extends StatefulWidget {
  final Movie movie;
  MovieCardVetical(this.movie);
  @override
  _MovieCardVeticalState createState() => _MovieCardVeticalState();
}

class _MovieCardVeticalState extends State<MovieCardVetical> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(CardDetailsPage.routeName, arguments: widget.movie.id),
        child: Hero(
          tag: widget.movie.id,
          child: Card(
            color: Provider.of<ThemeProvider>(context).getCardItemColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(15.0),
            ),
            elevation: 5,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      widget.movie.largeCoverImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RateStar(widget.movie.rating),
                          IconButton(
                            icon: Icon(Icons.favorite, size: 30),
                            onPressed: () {},
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Text(
                        widget.movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
