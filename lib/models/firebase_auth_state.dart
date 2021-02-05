import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthState extends ChangeNotifier {
  //맨 처음, 유저의 로그인 유무를 파악
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.signout;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //이 값을 이용해 유저가 로그인 or 로그아웃 or 진행중인지 판단
  User _user;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _user == null) {
        return;
      } else if (firebaseUser != _user) {
        _user = firebaseUser;
        changeFirebaseAuthStatus();
      }
    });
  }

  void changeFirebaseAuthStatus([FirebaseAuthStatus firebaseAuthStatus]) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else if (_user != null) {
      _firebaseAuthStatus = FirebaseAuthStatus.signin;
    } else {
      _firebaseAuthStatus = FirebaseAuthStatus.signout;
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
