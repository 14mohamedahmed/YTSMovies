

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/pages/card_details_page.dart';
import 'package:ytsm/pages/details_page.dart';
import 'package:ytsm/pages/home_page.dart';
import 'package:ytsm/providers/movies_provider.dart';
import 'package:ytsm/providers/search_movie_provider.dart';
import 'package:ytsm/providers/theme_provider.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(false),
        child: App(),
      ),
    );

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
        debugShowCheckedModeBanner: false,
        title: 'YTS Mo3tayat',
        theme: Provider.of<ThemeProvider>(context).getTheme(context),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          DetailsPage.routeName: (context) => DetailsPage(),
          CardDetailsPage.routeName:(context)=>CardDetailsPage(),
        },
      ),
    );
  }
}
