import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Post extends StatelessWidget {
  final int index;

  Post(this.index);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/200/200',
      imageBuilder: (BuildContext context, ImageProvider imageProvider) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}
