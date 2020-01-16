import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/pages/home_page.dart';
import 'package:ytsm/providers/movies_provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'YTS Mo3tayat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
