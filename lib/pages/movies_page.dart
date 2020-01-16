import 'package:flutter/cupertino.dart';

class MoviesPage extends StatelessWidget {
  final Key key;

  MoviesPage(this.key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('movies'),
    );
  }
}
