import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Date extends StatelessWidget {
  const Date({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return Text(
      //DateTime.now().toString(),
      formattedDate,
      style: TextStyle(
        color: Colors.blue[200],
        fontSize: 17.0,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
