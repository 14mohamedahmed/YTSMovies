import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/pages/details_page.dart';
import 'package:ytsm/pages/home_page.dart';
import 'package:ytsm/providers/movies_provider.dart';
import 'package:ytsm/providers/search_movie_provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchMovieProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'YTS Mo3tayat',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          DetailsPage.routeName: (context) => DetailsPage(),
        },
      ),
    );
  }
}
