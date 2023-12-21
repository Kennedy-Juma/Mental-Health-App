import 'package:flutter/material.dart';
import '../../../constant.dart';
import '../../../forgot/change_password.dart';
import '../account/UserProfile.dart';
import '../notification/components/defaultAppBar.dart';
import '../notification/components/defaultBackButton.dart';


class Setting extends StatefulWidget {
  Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool enableAnonymity = false; // Track the notification setting

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: 'Settings',
        child: DefaultBackButton(),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: settingLabel.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              settingLabel[index],
              style: TextStyle(
                fontSize: 16.0,
                color: index % 4 == 0 ? kDarkColor : kDarkColor.withOpacity(0.6),
              ),
            ),
            trailing: settingLabel[index] == 'Remain Anonymous'
                ? Switch(
              activeColor: Colors.blue,
              value: enableAnonymity,
              onChanged: (bool value) {
                setState(() {
                  enableAnonymity = value;
                });
              },
            )
                : Icon(
              Icons.arrow_forward_ios,
              size: 20.0,
              color: index % 4 == 0 ? kDarkColor : kDarkColor.withOpacity(0.6),
            ),
            enabled: settingLabel[index] == 'Settings' ||
                settingLabel[index] == 'Settings'
                ? false
                : true,
            onTap: () => setState(() {
              switch (settingLabel[index]) {
                case 'My Profile':
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfilePage(),
                  ));
                  break;
                case 'Change Password':
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangePasswordPage(),
                  ));
                  break;
                case 'Remain Anonymous':
                // Handle the toggle button tap here if needed
                  break;
              }
            }),
          );
        },
        separatorBuilder: (context, index) {
          return settingLabel[index] == 'Email' ||
              settingLabel[index] == 'Credit Card'
              ? kSmallDivider
              : Divider();
        },
      ),
    );
  }

// ... Other methods like snackBarMsg and signOutDrawer ...
}



/*class _SettingState extends State<Setting> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhiteColor,
      appBar: DefaultAppBar(
        title: 'Settings',
        child: DefaultBackButton(),
      ),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: settingLabel.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              settingLabel[index],
              style: TextStyle(
                fontSize: 16.0,
                color:
                    index % 4 == 0 ? kDarkColor : kDarkColor.withOpacity(0.6),
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20.0,
              color: index % 4 == 0 ? kDarkColor : kDarkColor.withOpacity(0.6),
            ),
            enabled: settingLabel[index] == 'Settings' ||
                    settingLabel[index] == 'Settings'
                ? false
                : true,
            onTap: () => this.setState(() {
              switch (settingLabel[index]) {
                case 'My Profile':
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfilePage(), // Replace with your AddressPage widget
                  ));
                  break;
                case 'Change Password':
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfilePage(), // Replace with your AddressPage widget
                  ));
                  break;
                case 'Notifications':
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditProfilePage(), // Replace with your AddressPage widget
                  ));
                  break;

              }
            }),
          );
        },
        separatorBuilder: (context, index) {
          return settingLabel[index] == 'Email' ||
                  settingLabel[index] == 'Credit Card'
              ? kSmallDivider
              : Divider();
        },
      ),
    );
  }

  snackBarMsg(BuildContext context, String text) {
    var sb = SnackBar(
      elevation: kRadius,
      content: Text(text),
      duration: new Duration(seconds: 3),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
      ),
    );
    scaffoldKey.currentState.showSnackBar(sb);
  }
}*/

void signOutDrawer(BuildContext context) {
  showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          color: kPrimaryColor,
          height: 150.0,
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Are you sure you want Logout ?',
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      color: kWhiteColor,
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: kWhiteColor),
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: kWhiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                  ),
                ],
              ),
            ],
          ),
        );
      });
}
