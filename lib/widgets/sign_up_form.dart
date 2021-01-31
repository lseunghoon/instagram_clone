import 'package:flutter/material.dart';
import 'package:instagram_clone/constants/auth_input_deco.dart';
import 'package:instagram_clone/home_page.dart';
import 'package:instagram_clone/widgets/common_size.dart';
import 'package:instagram_clone/widgets/or_divider.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _cpwController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _cpwController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: common_l_gap,
              ),
              Image.asset('assets/images/insta_text_logo.png'),
              TextFormField(
                validator: (text) {
                  if (text.isNotEmpty && text.contains('@')) {
                    return null;
                  } else {
                    return '정확한 이메일 주소를 입력해주세요';
                  }
                },
                controller: _emailController,
                decoration: inputTextDeco('Email'),
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                validator: (text) {
                  if (text.isNotEmpty && text.length > 5) {
                    return null;
                  } else {
                    return '비밀번호는 다섯자리 이상이어야 합니다';
                  }
                },
                controller: _pwController,
                decoration: inputTextDeco('Password'),
                cursorColor: Colors.black54,
                obscureText: true,
              ),
              SizedBox(
                height: common_xs_gap,
              ),
              TextFormField(
                validator: (text) {
                  if (text.isNotEmpty && _pwController.text == text) {
                    return null;
                  } else {
                    return '비밀번호와 비밀번호 확인 값이 일치하지 않습니다';
                  }
                },
                controller: _cpwController,
                decoration: inputTextDeco('Confirm Password'),
                cursorColor: Colors.black54,
                obscureText: true,
              ),
              SizedBox(
                height: common_s_gap,
              ),
              _submitButton(context),
              SizedBox(
                height: common_s_gap,
              ),
              OrDivider(),
              FlatButton.icon(
                textColor: Colors.blue,
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage('assets/images/facebook.png'),
                ),
                label: Text('Login with Facebook'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlatButton _submitButton(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      },
      child: Text(
        'Join',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
