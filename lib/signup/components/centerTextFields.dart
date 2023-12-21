
import 'package:flutter/material.dart';

import '../../constant.dart';
import 'defaultTextField.dart';

class CenterTextfields extends StatelessWidget {
  TextEditingController fullNameFieldController = TextEditingController();
  TextEditingController phoneFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextField(
            controller: fullNameFieldController,
            hintText: 'Full Name',
            icon: Icons.person,
            keyboardType: TextInputType.text,
            obscureText: false,
          ),
          SizedBox(height: kDefaultPadding),
          DefaultTextField(
            controller: phoneFieldController,
            hintText: 'Phone Number',
            icon: Icons.person,
            keyboardType: TextInputType.text,
            obscureText: false,
          ),
          SizedBox(height: kDefaultPadding),
          DefaultTextField(
            controller: emailFieldController,
            hintText: 'Email address',
            icon: Icons.mail,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
          ),
          SizedBox(height: kDefaultPadding),
          DefaultTextField(
            controller: passwordFieldController,
            hintText: 'Password',
            icon: Icons.lock,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
          ),

        ],
      ),
    );
  }
}
