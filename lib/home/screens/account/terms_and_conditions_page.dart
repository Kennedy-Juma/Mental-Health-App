import 'package:flutter/material.dart';
import 'package:mental_health_app_ui/home/screens/notification/components/defaultAppBar.dart';

import '../notification/components/defaultBackButton.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsPage createState() => _TermsAndConditionsPage();
}

class _TermsAndConditionsPage extends State<TermsAndConditionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Terms and Conditions',
        child: DefaultBackButton(),

      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Mental Health App!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'By using our app, you agree to the following terms and conditions. '
                    'Please read them carefully before using the app.',
              ),
              SizedBox(height: 20),
              Text(
                '1. Acceptance of Terms',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'By using this app, you agree to be bound by these terms and conditions, '
                    'all applicable laws and regulations, and agree that you are responsible '
                    'for compliance with any applicable local laws.',
              ),
              SizedBox(height: 20),
              Text(
                '2. Use License',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Permission is granted to use this app for personal, non-commercial transitory '
                    'viewing only. This is the grant of a license, not a transfer of title.',
              ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}
