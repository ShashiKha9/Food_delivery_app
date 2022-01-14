import 'package:flutter/cupertino.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({Key? key,required this.rating}) : super(key: key);
  final int rating;

  @override
  Widget build(BuildContext context) {
    String stars=" ";
    for(int i =0;i<rating;i++){
      stars+="⭐ ";

    }
    return Text(stars);
  }
}
