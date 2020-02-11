import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ytsm/pages/movies_page.dart';
import 'package:ytsm/pages/search_page.dart';
import 'package:ytsm/pages/setting_page.dart';
import 'package:ytsm/pages/upcoming_page.dart';
import 'package:ytsm/providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  static final String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageKey keyOne = PageStorageKey('keyOne');

  final PageStorageKey keyTwo = PageStorageKey('keyTwo');

  final PageStorageKey keyThree = PageStorageKey('keyThree');

  final PageStorageKey ketFour = PageStorageKey('keyFour');

  final PageStorageBucket storageBucket = PageStorageBucket();

  int _navigationIndex = 0;

  Widget currentPage;

  MoviesPage moviesPage;

  UpcomingPage upcomingPage;

  SearchPage searchPage;

  SettingPage settingPage;

  List<Widget> pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    moviesPage = MoviesPage(keyOne);
    upcomingPage = UpcomingPage(keyTwo);
    searchPage = SearchPage(keyThree);
    settingPage = SettingPage(ketFour);
    pages = [moviesPage, upcomingPage, searchPage, settingPage];
    currentPage = pages[_navigationIndex];
  }

  @override
  Widget build(BuildContext context) {
    final barItemColor = Provider.of<ThemeProvider>(context).getBarItemColor;
    final barIconColor =  Provider.of<ThemeProvider>(context).getBarIconColor;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Provider.of<ThemeProvider>(context).getThemebackground,
      body: PageStorage(
        bucket: storageBucket,
        child: currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              backgroundColor: barItemColor,
              icon: Icon(
                Icons.local_movies,
                color: barIconColor,
              ),
              title: Text(
                'Movies',
                style: Theme.of(context).textTheme.headline2,
              )),
          BottomNavigationBarItem(
            backgroundColor: barItemColor,
            icon: Icon(
              Icons.update,
              color: barIconColor,
            ),
            title: Text(
              'Upcoming',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: barItemColor,
            icon: Icon(
              Icons.search,
              color: barIconColor,
            ),
            title: Text(
              'Search',
              style: Theme.of(context).textTheme.headline2
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: barItemColor,
            icon: Icon(
              Icons.settings,
              color: barIconColor,
            ),
            title: Text(
              'Setting',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
        currentIndex: _navigationIndex,
        onTap: (value) {
          setState(() {
            _navigationIndex = value;
            currentPage = pages[_navigationIndex];
          });
        },
      ),
    );
  }
}
