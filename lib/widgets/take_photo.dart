import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/screen_size.dart';
import 'package:camera/camera.dart';
import 'package:instagram_clone/widgets/my_progress_indicator.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController _cameraController;
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.width,
                color: Colors.black,
                child:
                    (snapshot.hasData) ? _getPreview(snapshot.data) : _progress,
              ),
              Expanded(
                child: OutlineButton(
                  shape: CircleBorder(),
                  borderSide: BorderSide(color: Colors.black12, width: 20),
                  onPressed: () {},
                ),
              ),
            ],
          );
        });
  }

  Widget _getPreview(List<CameraDescription> cameras) {
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize();
    return FutureBuilder(
      future: _cameraController.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(_cameraController);
        } else {
          return MyProgressIndicator();
        }
      },
    );
  }
}
