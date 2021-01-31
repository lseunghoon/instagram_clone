import 'package:flutter/material.dart';
import 'package:instagram_clone/Screens/profile_screen.dart';
import 'package:instagram_clone/widgets/sign_in_form.dart';
import 'package:instagram_clone/widgets/sign_up_form.dart';

class FadeStack extends StatefulWidget {
  final int selectedForm;

  const FadeStack({Key key, this.selectedForm}) : super(key: key);
  @override
  _FadeStackState createState() => _FadeStackState();
}

class _FadeStackState extends State<FadeStack>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  List<Widget> forms = [SignUpForm(), SignInForm()];

  @override
  void didUpdateWidget(covariant FadeStack oldWidget) {
    if (widget.selectedForm != oldWidget.selectedForm) {
      _animationController.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: duration);
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: IndexedStack(
        index: widget.selectedForm,
        children: forms,
      ),
    );
  }
}
