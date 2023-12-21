import 'package:flutter/material.dart';


/*
class NotificationTiles extends StatelessWidget {
  final String title, subtitle;
  final Function onTap;
  final bool enable;
  const NotificationTiles({
    Key key, this.title, this.subtitle, this.onTap, this.enable, TextStyle titleStyle, TextStyle subtitleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
          height: 50.0,
          width: 50.0,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(logo), fit: BoxFit.cover))),
      title: Text(title, style: TextStyle(color: kDarkColor)),
      subtitle: Text(subtitle,
          style: TextStyle(color: kLightColor)),
      onTap: onTap,
      enabled: enable,
    );
  }
}*/


class NotificationTiles extends StatelessWidget {
  static const kLightColor =Color.fromARGB(255, 40, 48, 109);
  static const kDarkColor = Color(0xFF303030);

  final String? title, subtitle;
  final Function()? onTap;
  final bool? enable;
  final TextStyle? titleStyle; // Custom title text style
  final TextStyle? subtitleStyle; // Custom subtitle text style

  const NotificationTiles({
    Key? key,
   this.title,
     this.subtitle,
    this.onTap,
    this.enable,
    this.titleStyle, // Custom title text style parameter
    this.subtitleStyle, // Custom subtitle text style parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
/*      leading: Container(
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(logo), fit: BoxFit.cover),
        ),
      ),*/
      title: Text(
        title!,
        style: titleStyle ?? TextStyle(color: kDarkColor), // Apply custom title style or default
      ),
      subtitle: Text(
        subtitle!,
        style: subtitleStyle ?? TextStyle(color: kLightColor), // Apply custom subtitle style or default
      ),
      onTap: onTap,
      enabled: enable!,
    );
  }
}
