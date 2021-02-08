import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/firestore/user_model.dart';

class Transformers {
  //DocumentSnapshot 을 UserModel 로 변경시켜줌.
  final toUser = StreamTransformer<DocumentSnapshot, UserModel>.fromHandlers(
      handleData: (snapshot, sink) async {
    sink.add(
      UserModel.fromSnapshot(snapshot),
    );
  });
}
