
import 'package:flutter/material.dart';

import '../constant.dart';
import '../home/widgets/emptyAppBar.dart';
import '../home/widgets/topLogo.dart';
import '../signin/signin.dart';
import '../signup/components/clearFullButton.dart';
import '../signup/components/defaultButton.dart';
import '../signup/components/defaultTextField.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopLogo(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Text(
                        "Enter your registered email address. We'll send you an email to reset your password.",
                        style: kDarkTextStyle,
                      ),
                    ),
                    SizedBox(height: kDefaultPadding),
                    DefaultTextField(
                      obscureText: false,
                      hintText: 'Email address',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClearFullButton(
                      darkText: 'Back to',
                      colorText: ' SignIn.',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignIn())),
                    ),
                    DefaultButton(
                      btnText: 'Submit',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
