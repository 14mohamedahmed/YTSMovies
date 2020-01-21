import 'package:flutter/material.dart';
import 'package:ytsm/pages/movies_page.dart';
import 'package:ytsm/pages/search_page.dart';
import 'package:ytsm/pages/upcoming_page.dart';

class HomePage extends StatefulWidget {
  static final String routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageStorageKey keyOne = PageStorageKey('keyOne');

  final PageStorageKey keyTwo = PageStorageKey('keyTwo');

  final PageStorageKey keyThree = PageStorageKey('keyThree');

  final PageStorageBucket storageBucket = PageStorageBucket();

  int _navigationIndex = 0;

  Widget currentPage;

  MoviesPage moviesPage;

  UpcomingPage upcomingPage;

  SearchPage searchPage;

  List<Widget> pages;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    moviesPage = MoviesPage(keyOne);
    upcomingPage = UpcomingPage(keyTwo);
    searchPage = SearchPage(keyThree);
    pages = [moviesPage, upcomingPage, searchPage];
    currentPage = pages[_navigationIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageStorage(
        bucket: storageBucket,
        child: currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.local_movies,
                color: Colors.white,
              ),
              title: Text(
                'Movies',
                style: TextStyle(color: Colors.white),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.update,
              color: Colors.white,
            ),
            title: Text(
              'Upcoming',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            title: Text(
              'Search',
              style: TextStyle(color: Colors.white),
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
