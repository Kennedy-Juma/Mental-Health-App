
import 'package:flutter/material.dart';

import '../../constant.dart';

class ClearFullButton extends StatelessWidget {
  final String? darkText, colorText;
  final Function()? onPressed;
  const ClearFullButton({
    Key? key,
    this.darkText,
    this.colorText, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: darkText,
                style: kDarkTextStyle,
              ),
              TextSpan(
                text: colorText,
                style: kTitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );

  }
}
