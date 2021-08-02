import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height*0.04),
      child: RatingBar.builder(
        itemCount: 5,
        initialRating: 10 / 2,
        itemSize: 50,
        itemBuilder: (context, _) {
          return Icon(
            Icons.star,
            color: Colors.amber,
          );
        }, onRatingUpdate: (double value) {  },
        ignoreGestures: true,
        
      ),
    );
  }
}
