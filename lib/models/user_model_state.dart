import 'package:flutter/material.dart';
import 'package:instagram_clone/models/firestore/user_model.dart';

class UserModelState extends ChangeNotifier {
  UserModel _userModel;

  UserModel get userModel => _userModel;

  //값 변경될때마다 알려주는 역할.
  set userModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}
