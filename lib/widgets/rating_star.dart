import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final String ratingText;
  RatingStar(this.ratingText);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: 35,
        ),
        Text(
          ratingText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
