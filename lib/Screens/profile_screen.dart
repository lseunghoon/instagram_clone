import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/profile_body.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _appbar(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 44.0,
        ),
        Expanded(
          child: Text(
            'Profile title',
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ],
    );
  }
}
