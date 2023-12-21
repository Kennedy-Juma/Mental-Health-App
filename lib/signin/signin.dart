import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiServices/APIService.dart';
import '../constant.dart';
import '../forgot/forgot.dart';
import '../home/widgets/emptyAppBar.dart';
import '../home/widgets/topLogo.dart';
import '../signup/components/clearFullButton.dart';
import '../signup/components/defaultButton.dart';
import '../signup/components/defaultTextField.dart';
import '../signup/signup.dart';


class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();

  Future<void> saveUserEmail(String email) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'user_email', value: email);
  }



   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TopLogo(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultTextField(
                      controller: emailFieldController,
                      obscureText: false,
                      hintText: 'Email address',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: kFixPadding),
                    DefaultTextField(
                      controller: passwordFieldController,
                      obscureText: true,
                      hintText: 'Password',
                      icon: Icons.lock,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: kFixPadding),
                    ClearFullButton(
                      darkText: 'I forgot my',
                      colorText: ' Password.',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword())),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClearFullButton(
                      darkText: "Don't have an account?",
                      colorText: ' SignUp.',
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignUp())),
                    ),
                    DefaultButton(
                      btnText: 'Sign In',
                      onPressed: (){

                        final email=emailFieldController.text;
                        final password=passwordFieldController.text;
                        ApiService(context).login(email, password);
                        // Navigator.of(context).push(
                        //     MaterialPageRoute(builder: (context) => BottomNavBar(0))
                        // );
                        saveUserEmail(email);
                      }
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


