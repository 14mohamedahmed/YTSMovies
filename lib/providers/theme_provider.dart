import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark;
  ThemeProvider(this.isDark);
  get getThemebackground => !isDark ? Colors.black : Colors.white;

  get getBarItemColor => !isDark ? Colors.black : Colors.white;
  get getBarIconColor => isDark ? Colors.black : Colors.white;

  getTheme(BuildContext context) =>
      !isDark ? darkTheme(context) : lightTheme(context);

  set setThemeData(bool val) {
    if (val) {
      isDark = true;
    } else {
      isDark = false;
    }
    notifyListeners();
  }
}

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.green,
    textTheme: Theme.of(context).textTheme.copyWith(
          headline1: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          headline2: TextStyle(color: Colors.white, fontSize: 15),
          headline3: TextStyle(color: Colors.white, fontSize: 18),
          headline4: TextStyle(color: Colors.white, fontSize: 14),
        ),
  );
}

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primarySwatch: Colors.green,
    textTheme: Theme.of(context).textTheme.copyWith(
          headline1: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          headline2: TextStyle(color: Colors.black, fontSize: 15),
          headline3: TextStyle(color: Colors.black, fontSize: 18),
          headline4: TextStyle(color: Colors.black, fontSize: 14),
        ),
  );
}
