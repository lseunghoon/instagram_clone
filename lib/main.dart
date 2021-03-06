import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/auth_screen.dart';
import 'package:instagram_clone/home_page.dart';
import 'package:instagram_clone/models/firebase_auth_state.dart';
import 'package:instagram_clone/models/firestore/user_model.dart';
import 'package:instagram_clone/models/user_model_state.dart';
import 'package:instagram_clone/repo/user_network_repo.dart';
import 'package:instagram_clone/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'constants/material_white.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAuthState _firebaseAuthState = FirebaseAuthState();
  Widget _currentWidget;

  @override
  Widget build(BuildContext context) {
    _firebaseAuthState.watchAuthChange();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthState>.value(
            value: _firebaseAuthState),
        ChangeNotifierProvider<UserModelState>(
          create: (_) => UserModelState(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Consumer<FirebaseAuthState>(
          builder: (BuildContext context, FirebaseAuthState firebaseAuthState,
              Widget child) {
            switch (firebaseAuthState.firebaseAuthStatus) {
              case FirebaseAuthStatus.signout:
                _currentWidget = AuthScreen();
                break;
              case FirebaseAuthStatus.signin:
                userNetworkRepository
                    .getUserModelStream(firebaseAuthState.user.uid)
                    .listen((userModel) {
                  Provider.of<UserModelState>(context, listen: false)
                      .userModel = userModel;
                });
                _currentWidget = HomePage();
                break;
              default:
                _currentWidget = MyProgressIndicator();
            }

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _currentWidget,
            );
          },
        ),
      ),
    );
  }
}
