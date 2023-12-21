import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app_ui/home/screens/notification/components/defaultAppBar.dart';

import '../notification/components/defaultBackButton.dart';

class UserPrivacyPage extends StatefulWidget {
  const UserPrivacyPage({super.key});

  @override
  _UserPrivacyPage createState() => _UserPrivacyPage();
}

class _UserPrivacyPage extends State<UserPrivacyPage> {
  late String formattedDate;
  @override
  Widget build(BuildContext context) {
    formattedDate = DateFormat.yMMMMd('en_US').format(DateTime.now());
    return  Scaffold(
      appBar: const DefaultAppBar(
        title: 'User Privacy',
        child: DefaultBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Our Commitment to Your Privacy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(

                'Last Updated: $formattedDate',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'At [Your App Name], we are committed to ensuring the privacy and security of your personal information. This Privacy Policy outlines the types of information we collect, how we use it, and the measures we take to protect your data.',
              ),
              SizedBox(height: 20),
              Text(
                'Information We Collect',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We collect the following types of information:',
              ),
              SizedBox(height: 5),
              Text('1. Personal Information: Name, email address, and other information you voluntarily provide.'),
              Text('2. Device Information: Information about your device, including device type and operating system.'),
              Text('3. Usage Data: Information about how you use our app, such as interactions and preferences.'),
              SizedBox(height: 10),
              Text(
                'How We Use Your Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We use the information we collect for the following purposes:',
              ),
              SizedBox(height: 5),
              Text('1. To provide and maintain our services.'),
              Text('2. To personalize your experience and improve our app.'),
              Text('3. To communicate with you, including responding to inquiries and providing updates.'),
              SizedBox(height: 20),
              Text(
                'Data Security and Storage',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We implement strict security measures to protect your information against unauthorized access and use. Your data is stored securely and is accessible only to authorized personnel.',
              ),
              SizedBox(height: 20),
              Text(
                'Your Choices and Rights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'You have the right to:',
              ),
              SizedBox(height: 5),
              Text('1. Access, update, or delete your personal information.'),
              Text('2. Opt-out of certain data processing activities.'),
              Text('3. Withdraw your consent for data processing.'),
              SizedBox(height: 20),
              Text(
                'Changes to Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'We may update our Privacy Policy from time to time. Any changes will be communicated to you, and your continued use of the app after such changes signifies your acceptance of the updated policy.',
              ),
              SizedBox(height: 20),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              const Text(
                'If you have any questions or concerns about our Privacy Policy, please contact us at privacy@mentalhealthapp.com.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
