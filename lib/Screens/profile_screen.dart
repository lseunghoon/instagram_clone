import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/profile_body.dart';
import 'package:instagram_clone/constants/screen_size.dart';

class ProfileScreen extends StatelessWidget {
  final duration = Duration(milliseconds: 300);
  MenuStatus _menuStatus = MenuStatus.closed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            duration: duration,
            child: ProfileBody(onMenuChanged: () {}),
          ),
          AnimatedContainer(
            duration: duration,
            child: Positioned(
              top: 0,
              bottom: 0,
              width: size.width / 2,
              child: Container(
                color: Colors.deepPurpleAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum MenuStatus { opened, closed }
