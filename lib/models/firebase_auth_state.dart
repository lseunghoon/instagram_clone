import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:instagram_clone/utils/simple_snackbar.dart';

class FirebaseAuthState extends ChangeNotifier {
  //맨 처음, 유저의 로그인 유무를 파악
  FirebaseAuthStatus _firebaseAuthStatus = FirebaseAuthStatus.progress;

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //이 값을 이용해 유저가 로그인 or 로그아웃 or 진행중인지 판단
  User _user;

  FacebookLogin _facebookLogin;

  void watchAuthChange() {
    _firebaseAuth.authStateChanges().listen((firebaseUser) {
      if (firebaseUser == null && _user == null) {
        changeFirebaseAuthStatus();
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

  void registerUser(BuildContext context,
      {@required String email, @required String password}) {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

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
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

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

  void signOut() async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);
    _firebaseAuthStatus = FirebaseAuthStatus.signout;
    if (_user != null) {
      _user = null;
      await _firebaseAuth.signOut();
      //로그인이 되어있는지 아닌지 확인.
      if (await _facebookLogin.isLoggedIn) {
        await _facebookLogin.logOut();
      }
    } else {
      print('not good');
    }
    //변경사항을 구독하고 있는 리스너들에게 전달하는 역할.
    notifyListeners();
  }

  void loginWithFacebook(BuildContext context) async {
    changeFirebaseAuthStatus(FirebaseAuthStatus.progress);

    if (_facebookLogin == null) _facebookLogin = FacebookLogin();
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        _handleFacebookTokenWithFirebase(context, result.accessToken.token);
        break;
      case FacebookLoginStatus.cancelledByUser:
        simpleSnackBar(context, '사용자가 페이스북 로그인을 취소하였습니다.');
        break;
      case FacebookLoginStatus.error:
        simpleSnackBar(context, '에러가 발생하였습니다.');
        _facebookLogin.logOut();
        break;
    }
  }

  void _handleFacebookTokenWithFirebase(
      BuildContext context, String token) async {
    final AuthCredential credential = FacebookAuthProvider.credential(token);

    final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    final User user = userCredential.user;

    if (user == null) {
      simpleSnackBar(context, '페이스북 로그인에 실패하였습니다.');
    } else {
      _user = user;
    }
    notifyListeners();
  }

  FirebaseAuthStatus get firebaseAuthStatus => _firebaseAuthStatus;
}

enum FirebaseAuthStatus { signout, progress, signin }
