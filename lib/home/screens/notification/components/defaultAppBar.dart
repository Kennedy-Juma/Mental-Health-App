import 'package:flutter/material.dart';


class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? title;
  final Widget? child;
  final action;
  const DefaultAppBar({
    Key? key, this.title, this.child, this.action,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: Colors.blue,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: Colors.white),
      leading: child,
      actions: action,
    );
  }
}