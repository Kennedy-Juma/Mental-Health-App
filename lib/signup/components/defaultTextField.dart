
import 'package:flutter/material.dart';

import '../../constant.dart';

class DefaultTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final keyboardType, obscureText;
  final TextEditingController? controller;
  const DefaultTextField({
    Key? key,
    this.hintText,
    this.icon,
    this.keyboardType,
    this.obscureText,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kShape)),
        color: kAccentColor,
      ),
      child: TextField(
        controller:controller ,
        cursorColor: kPrimaryColor,
        textInputAction: TextInputAction.next,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: kPrimaryColor),
          hintText: hintText,

        ),
      ),
    );
  }
}
