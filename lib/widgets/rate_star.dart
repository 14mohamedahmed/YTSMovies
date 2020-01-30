import 'package:flutter/material.dart';

class RateStar extends StatelessWidget {
  final String rate;
  final double size;
  final Color textColor;
  RateStar(this.rate,{this.size = 35, this.textColor=Colors.black});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.yellow,
          size: size,
        ),
        Text(
          rate,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: textColor
          ),
        ),
      ],
    );
  }
}
