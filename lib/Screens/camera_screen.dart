import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';
import 'package:instagram_clone/models/camera_state.dart';
import 'package:instagram_clone/widgets/take_photo.dart';
import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  CameraState _cameraState = CameraState();

  @override
  _CameraScreenState createState() {
    _cameraState.getReadyToTakePhoto();
    return _CameraScreenState();
  }
}

class _CameraScreenState extends State<CameraScreen> {
  PageController _pageController = PageController(initialPage: 1);

  int _currentIndex = 1;

  String _title = 'Photo';

  @override
  void dispose() {
    _pageController.dispose();
    widget._cameraState.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //여기에 멀티프로바이더를 주면 scaffold 안에서는 전부 프로바이더 사용 가능.
      providers: [
        ChangeNotifierProvider<CameraState>.value(value: widget._cameraState),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_title),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            Container(
              color: Colors.cyanAccent,
            ),
            TakePhoto(),
            Container(
              color: Colors.yellowAccent,
            ),
          ],
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
              switch (_currentIndex) {
                case 0:
                  _title = 'Gallery';
                  break;
                case 1:
                  _title = 'Photo';
                  break;
                case 2:
                  _title = 'Video';
                  break;
              }
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          iconSize: 0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.forward), label: 'GALLERY'),
            BottomNavigationBarItem(icon: Icon(Icons.forward), label: 'PHOTO'),
            BottomNavigationBarItem(icon: Icon(Icons.forward), label: 'VIDEO'),
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTab,
        ),
      ),
    );
  }

  _onItemTab(index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(milliseconds: 200), curve: Curves.fastOutSlowIn);
    });
  }
}
