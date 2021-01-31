import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/common_size.dart';

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
    return Padding(
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
              decoration: _inputTextDeco('Email'),
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
              decoration: _inputTextDeco('Password'),
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
              decoration: _inputTextDeco('Confirm Password'),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputTextDeco(String hint) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(common_s_gap),
        borderSide: BorderSide(color: Colors.grey[300]),
      ),
    );
  }
}
