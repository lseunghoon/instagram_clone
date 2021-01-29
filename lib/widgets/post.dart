import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_clone/constants/screen_size.dart';
import 'package:instagram_clone/widgets/avatar.dart';
import 'package:instagram_clone/widgets/comment.dart';
import 'package:instagram_clone/widgets/common_size.dart';
import 'package:instagram_clone/widgets/my_progress_indicator.dart';

class Post extends StatelessWidget {
  final int index;

  Post(this.index);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        username: 'testing username',
        text: 'testing text hahahahahah',
        showImage: false,
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '777 likes',
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/bookmark.png'),
            ),
            onPressed: null),
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/comment.png'),
            ),
            onPressed: null),
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/direct_message.png'),
            ),
            onPressed: null),
        Spacer(),
        IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/heart_selected.png'),
            ),
            onPressed: null),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: Avatar(),
        ),
        Expanded(
          child: Text('username'),
        ),
        IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Colors.black87,
            ),
            onPressed: null),
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/2000/2000',
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
      placeholder: (BuildContext context, String url) {
        return MyProgressIndicator(
          containerSize: size.width,
          progressSize: 50,
        );
      },
    );
  }
}
