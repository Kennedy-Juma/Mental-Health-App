
import 'package:flutter/material.dart';

import '../../constant.dart';

class DefaultButton extends StatelessWidget {
  final String? btnText;
  final  Function()? onPressed;
  const DefaultButton({
    Key? key, this.btnText, required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.symmetric(vertical: kLessPadding),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kShape),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
          foregroundColor: MaterialStateProperty.all(kWhiteColor),
          overlayColor: MaterialStateProperty.all(kTransparent),
        ),
        onPressed: onPressed,
        child: Text(btnText!.toUpperCase()),
      ),

    );
  }
}