import 'package:flutter/material.dart';
import 'package:mental_health_app_ui/home/screens/notification/components/defaultAppBar.dart';

import 'notification/components/defaultBackButton.dart';

class AppointmentPage extends StatefulWidget {
  final String exercise;

  AppointmentPage({
    Key? key,
    required this.exercise
  }) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  TextEditingController _problemController = TextEditingController();
  bool _isAnonymous = false;

  late String exercise;


  @override
  void initState() {
    exercise = widget.exercise;
    super.initState();
  }

  void _submitAppointment() {
    // Handle the appointment submission logic here
    print('Problem: ${_problemController.text}');
    print('Anonymous: $_isAnonymous');
    // Add your logic to submit the appointment
  }

  Future<void> _showAnonymousConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stay Anonymous?'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you want to submit this information anonymously?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _isAnonymous = true;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isAnonymous = false;
                });
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: 'Consultation with $exercise',
        child: DefaultBackButton(),
        ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _problemController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Describe your problem',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () async {
                await _showAnonymousConfirmationDialog();
                _submitAppointment();
              },
              child: const Text(
                  'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

