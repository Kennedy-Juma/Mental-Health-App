import 'package:flutter/material.dart';
import '../ApiServices/APIService.dart';
import '../constant.dart';
import '../home/widgets/emptyAppBar.dart';
import '../home/widgets/topLogo.dart';
import '../signin/signin.dart';
import 'components/clearFullButton.dart';
import 'components/defaultButton.dart';
import 'components/defaultTextField.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController fullNameFieldController = TextEditingController();
  TextEditingController phoneFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: EmptyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              TopLogo(),
              Expanded(
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
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClearFullButton(
                      darkText: 'Already have an account?',
                      colorText: ' SignIn',
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn()),
                      ),
                    ),
                    DefaultButton(
                      btnText: 'Sign Up',
                      onPressed: (){
                        final fullName=fullNameFieldController.text;
                        final phone=phoneFieldController.text;
                        final email=emailFieldController.text;
                        final password=passwordFieldController.text;
                        ApiService(context).signUp(fullName, phone, email, password);
                      },
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
