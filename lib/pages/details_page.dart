import 'package:flutter/material.dart';
import 'package:ytsm/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/widgets/rating_star.dart';

class DetailsPage extends StatefulWidget {
  static const String routeName = '/deatails-page';
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  MoviesProvider moviesProvider;
  @override
  Widget build(BuildContext context) {
    final moviesId = ModalRoute.of(context).settings.arguments;
    moviesProvider = Provider.of<MoviesProvider>(context);
    final filterdMovie = moviesProvider.fetchMovieDetailsById(moviesId);
    print(moviesId);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 250,
                    width: 150,
                    child: Image.network(filterdMovie.largeCoverImage),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Container(
                    width: 200,
                    height: 250,
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            filterdMovie.titleLong,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  crossAxisCount: 3,
                                  childAspectRatio: 3),
                          children: <Widget>[
                            for (var gen in filterdMovie.genres)
                              Text(
                                gen,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            RatingStar(filterdMovie.rating),
                            Text(
                              filterdMovie.language,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Title('Description'),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 8.0),
                child: Text(
                  filterdMovie.descriptionFull,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              Title('Trailler'),
              // TODO VideoPlayerWidget(),
              // TODO Download Movies
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final String titleText;
  Title(this.titleText);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, top: 8.0),
      child: Text(
        titleText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );
  }
}

// CustomScrollView(slivers: <Widget>[
          //   SliverAppBar(
          //     expandedHeight: 300,
          //     pinned: true,
          //     flexibleSpace: FlexibleSpaceBar(
          //       title: Text(
          //         filterdMovie.title,
          //       ),
          //       background: Hero(
          //         tag: filterdMovie.id,
          //         child: Image.network(
          //           filterdMovie.largeCoverImage,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //   ),
          //   SliverList(
          //     delegate: SliverChildListDelegate(
          //       [
          //         SizedBox(
          //           height: 10.0,
          //         ),
          //         Text(
          //           filterdMovie.titleLong,
          //           style: TextStyle(color: Colors.grey, fontSize: 24),
          //           textAlign: TextAlign.center,
          //         ),
          //         SizedBox(
          //           height: 10.0,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: <Widget>[
          //             Stack(
          //               alignment: Alignment.center,
          //               children: <Widget>[
          //                 Icon(
          //                   Icons.star,
          //                   color: Colors.yellow,
          //                   size: 35,
          //                 ),
          //                 Text(
          //                   filterdMovie.rating,
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 12,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Text(
          //               filterdMovie.language,
          //               style: TextStyle(
          //                 fontSize: 15,
          //               ),
          //             ),
          //             Text(
          //               filterdMovie.year.toString(),
          //               style: TextStyle(
          //                 fontSize: 15,
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 10.0,
          //         ),
          //         Text(
          //           'Geners',
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 10.0,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: <Widget>[
          //             for (var element in filterdMovie.genres)
          //               Text(
          //                 element,
          //                 style: TextStyle(
          //                   fontSize: 15,
          //                 ),
          //               ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 10.0,
          //         ),
          //         Text(
          //           filterdMovie.descriptionFull,
          //           textAlign: TextAlign.center,
          //           softWrap: true,
          //         ),
          //       ],
          //     ),
          //   )
          // ]),