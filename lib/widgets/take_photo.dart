import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/share_post_screen.dart';
import 'package:instagram_clone/constants/screen_size.dart';
import 'package:camera/camera.dart';
import 'package:instagram_clone/models/camera_state.dart';
import 'package:instagram_clone/widgets/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Consumer<CameraState>(
      builder: (BuildContext context, CameraState cameraState, Widget child) {
        return Column(
          children: <Widget>[
            Container(
              width: size.width,
              height: size.width,
              color: Colors.black,
              child: (cameraState.readyTakePhoto)
                  ? _getPreview(cameraState)
                  : _progress,
            ),
            Expanded(
              child: OutlineButton(
                shape: CircleBorder(),
                borderSide: BorderSide(color: Colors.black12, width: 20),
                onPressed: () {
                  if (cameraState.readyTakePhoto)
                    _attempTakePhoto(cameraState, context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _getPreview(CameraState cameraState) {
    return ClipRect(
      child: OverflowBox(
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: size.width,
            height: size.width / cameraState.cameraController.value.aspectRatio,
            child: CameraPreview(cameraState.cameraController),
          ),
        ),
      ),
    );
  }

  void _attempTakePhoto(CameraState cameraState, BuildContext context) async {
    final String timeInMilli = DateTime.now().millisecondsSinceEpoch.toString();
    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        '$timeInMilli.png',
      );
      await cameraState.cameraController.takePicture(path);

      File imageFile = File(path);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => SharePostScreen(imageFile),
        ),
      );
    } catch (e) {}
  }
}
