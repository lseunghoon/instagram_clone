import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';
import 'package:instagram_clone/widgets/fade_stack.dart';
import 'package:instagram_clone/widgets/sign_in_form.dart';
import 'package:instagram_clone/widgets/sign_up_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FadeStack(
              selectedForm: selectedForm,
            ),
            Container(
              child: FlatButton(
                child: Text('go to Sign up'),
                onPressed: () {
                  setState(
                    () {
                      if (selectedForm == 0) {
                        selectedForm = 1;
                      } else {
                        selectedForm = 0;
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
