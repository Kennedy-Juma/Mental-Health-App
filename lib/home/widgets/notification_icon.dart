import 'package:flutter/material.dart';
import 'package:mental_health_app_ui/home/screens/account/account.dart';


import '../screens/notification/notificationList.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Account(),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(
              15.0,
            ),
            decoration: BoxDecoration(
              color: Colors.blue[600],
              borderRadius: const BorderRadius.all(Radius.circular(
                12.0,
              )),
            ),
            child: const Icon(
              Icons.person,
              size: 28.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4.0),
          const Text(
            'My Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),
          ),
        ],
      ),
    );
  }
}
