import 'package:flutter/material.dart';

class RoundImage extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final String url;

  RoundImage({this.radius, this.url, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}
