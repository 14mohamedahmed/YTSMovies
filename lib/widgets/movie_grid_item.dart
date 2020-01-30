import 'package:flutter/material.dart';
import 'package:ytsm/widgets/rate_star.dart';
import '../models/movie.dart';
import '../pages/details_page.dart';

class MovieGridItem extends StatefulWidget {
  final Movie movie;

  MovieGridItem(this.movie);

  @override
  _MovieGridItemState createState() => _MovieGridItemState();
}

class _MovieGridItemState extends State<MovieGridItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      // will not work here just remove it
      /*  decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(15.0),
        ),*/
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RateStar(widget.movie.rating),
            ],
          ),
          footer: Container(
            height: 45,
            alignment: Alignment.center,
            color: Colors.black54,
            child: Text(
              widget.movie.title + ' ' + widget.movie.year.toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          child: GestureDetector(
            onTap: () => {
              Navigator.of(context)
                  .pushNamed(DetailsPage.routeName, arguments: widget.movie.id)
            },
            child: Hero(
              tag: widget.movie..id,
              child: Image.network(
                widget.movie.largeCoverImage,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
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
    );
  }
}
