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

  void changeFirebaseAuthStatus({FirebaseAuthStatus firebaseAuthStatus}) {
    if (firebaseAuthStatus != null) {
      _firebaseAuthStatus = firebaseAuthStatus;
    } else if (_user != null) {
      _firebaseAuthStatus = FirebaseAuthStatus.signin;
    } else {
      _firebaseAuthStatus = FirebaseAuthStatus.signout;
    }
    notifyListeners();
  }

  void registerUser(BuildContext context,
      {@required String email, @required String password}) {
    _firebaseAuth
        //이메일과 패스워드 뒤에 trim() 을 추가하면 띄어쓰기를 무시 가능.
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = '';
      switch (error.code) {
        case 'email-already-in-use':
          _message = '이미 사용하고 있는 이메일입니다.';
          break;
        case 'invalid-email':
          _message = '사용할 수 없는 이메일입니다.';
          break;
        case 'operation-not-allowed':
          _message = '활성화되지 않은 사용자입니다.';
          break;
        case 'weak-password':
          _message = '비밀번호의 보안수준이 낮습니다.';
          break;
      }
      //Snackbar로 오류 메세지 전달 가능.
      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );

      //Scaffold.of(context)의 context는 Scaffold 아래에 있는것이어야한다. 거슬러 올라가보면 알 수 있음.
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void signIn(BuildContext context,
      {@required String email, @required String password}) {
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .catchError((error) {
      print(error);
      String _message = '';
      switch (error.code) {
        case 'invalid-email':
          _message = '사용할 수 없는 이메일입니다.';
          break;
        case 'user-disabled':
          _message = '해당 사용자는 비활성화 상태입니다.';
          break;
        case 'user-not-found':
          _message = '없는 이메일 입니다.';
          break;
        case 'wrong-password':
          _message = '비밀번호가 틀렸습니다.';
          break;
      }
      //Snackbar로 오류 메세지 전달 가능.
      SnackBar snackBar = SnackBar(
        content: Text(_message),
      );

      //Scaffold.of(context)의 context는 Scaffold 아래에 있는것이어야한다. 거슬러 올라가보면 알 수 있음.
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  void signOut() {
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_user != null) {
      _user = null;
      _firebaseAuth.signOut();
    } else {
      print('not good');
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
