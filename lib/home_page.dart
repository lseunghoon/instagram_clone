import 'dart:html';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/camera_screen.dart';
import 'package:instagram_clone/Screens/feed_screen.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';
import 'package:instagram_clone/constants/screen_size.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btnNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ''),
  ];

  int selectedIndex = 0;

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  List<Widget> screens = [
    FeedScreen(),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.greenAccent,
    ),
    Container(
      color: Colors.deepPurpleAccent,
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }

    return Scaffold(
      key: _key,
      body: IndexedStack(
        index: selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        items: btnNavItems,
        currentIndex: selectedIndex,
        onTap: _onBottomItemClick,
      ),
    );
  }

  void _onBottomItemClick(index) {
    switch (index) {
      case 2:
        _openCamera();
        break;
      default:
        setState(() {
          selectedIndex = index;
        });
    }
  }

  void _openCamera() async {
    if (await checkIfPermissionGranted(context))
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CameraScreen(),
        ),
      );
    else {
      SnackBar snackBar = SnackBar(
        content: Text('사진, 파일, 마이크 접근 허용이 필수인 앱 입니다.'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            _key.currentState.hideCurrentSnackBar();
            AppSettings.openAppSettings();
          },
        ),
      );
      _key.currentState.showSnackBar(snackBar);
    }
  }

  Future<bool> checkIfPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
      Platform.isAndroid ? Permission.storage : Permission.photos
    ].request();
    bool permitted = true;

    statuses.forEach((permission, permissionStatus) {
      if (!permissionStatus.isGranted) permitted = false;
    });
    return permitted;
  }
}
