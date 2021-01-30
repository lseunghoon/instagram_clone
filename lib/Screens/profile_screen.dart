import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/profile_body.dart';
import 'package:instagram_clone/constants/screen_size.dart';
import 'package:instagram_clone/widgets/profile_side_menu.dart';

const duration = Duration(milliseconds: 300);

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  MenuStatus _menuStatus = MenuStatus.closed;

  final menuWidth = size.width / 3 * 2;
  double bodyXPos = 0;
  double menuXPos = size.width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: <Widget>[
          AnimatedContainer(
            transform: Matrix4.translationValues(bodyXPos, 0, 0),
            duration: duration,
            curve: Curves.fastOutSlowIn,
            child: ProfileBody(onMenuChanged: () {
              setState(() {
                _menuStatus = (_menuStatus == MenuStatus.closed)
                    ? _menuStatus = MenuStatus.opened
                    : _menuStatus = MenuStatus.closed;
                switch (_menuStatus) {
                  case MenuStatus.opened:
                    bodyXPos = -menuWidth;
                    menuXPos = menuXPos / 2;
                    break;
                  case MenuStatus.closed:
                    bodyXPos = 0;
                    menuXPos = size.width;
                    break;
                }
              });
            }),
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(menuXPos, 0, 0),
            duration: duration,
            curve: Curves.fastOutSlowIn,
            child: ProfileSideMenu(
              menuWidth: menuWidth,
            ),
          ),
        ],
      ),
    );
  }
}

enum MenuStatus { opened, closed }
