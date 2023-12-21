
import 'package:flutter/material.dart';
import 'package:mental_health_app_ui/signup/signup.dart';

import '../../home/widgets/bottom_nav_bar.dart';
import '../../signin/signin.dart';
import 'clearFullButton.dart';
import 'defaultButton.dart';

class BottomWidgets extends StatelessWidget {
  const BottomWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClearFullButton(
            darkText: 'Already have an account?',
            colorText: ' SignIn',
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignIn())),
          ),
          DefaultButton(
            btnText: 'Sign Up',
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUp())),
          ),
        ],
      ),
    );
  }
}
