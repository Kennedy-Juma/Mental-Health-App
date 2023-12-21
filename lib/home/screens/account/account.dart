import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app_ui/home/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiServices/APIService.dart';
import '../../../constant.dart';
import '../../../signin/signin.dart';
import '../../bloc/home_bloc.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../about/about.dart';
import '../callCenter/callCenter.dart';
import '../message/message.dart';
import '../notification/components/defaultBackButton.dart';
import '../notification/notificationList.dart';
import '../settings/setting.dart';


class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String userEmail = '';
  Uint8List? _profileImage;



  void getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail') ?? '';
    });
  }




/*  Future<void> retrieveProfileImage() async {
    try {
      final imageBytes = await ApiService(context).retrieveProfilePicture(userEmail);
      setState(() {
        _profileImage = imageBytes;
      });
    } catch (error) {
      print('Error retrieving profile image: $error');
    }
  }*/

  @override
  void initState() {
    super.initState();
    getUserEmail();
    //retrieveProfileImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none, alignment: Alignment.center,
            children: [
              Container(

                height: 250.0,
                child: const Image(
                  image: AssetImage(MentalMealthBanner),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: -60.0,
                child: Container(
                  height: 125.0,
                  width: 125.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                      color: kWhiteColor,
                      width: kLess,
                    ),
                    image: DecorationImage(
                      image: _profileImage!=null
                          ? MemoryImage(_profileImage!)
                          : AssetImage(profile) as ImageProvider
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -88.0,
                child: Text(
                  userEmail,
                  style: kDarkTextStyle,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 88.0),
              itemCount: labels.length,
              itemBuilder: (context, index) {
                return ListTile(
                    // dense: true,
                    leading: Icon(
                      icons[index],
                      color: Colors.blue[500],
                    ),
                    title: Text(labels[index]),
                    onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          switch (labels[index]) {
                            case 'My Mood Tracker':
                              return MyMoodList();
                              break;
                            case 'Settings':
                              return Setting();
                              break;
                            case 'About Application':
                              return About();
                              break;
                            case 'Logout':
                              return FutureBuilder<void>(
                                future: Future.delayed(const Duration(seconds: 1), () => ApiService(context).logout()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child:CircularProgressIndicator(semanticsLabel: 'Wait... Clearing Current Session and Logging out!',));
                                  } else if (snapshot.hasError) {
                                    // Handle errors if necessary
                                    return const Text('');
                                  } else {
                                    // Show confirmation message or navigate to the desired screen
                                    return const Text('');
                                  }
                                },
                              );

                              break;

                              //return SignIn();
                              //break;
                            default:
                              return MyMoodList();
                          }
                        }))

                    );
              },
            ),
          ),

        ],
      ),
    );
  }
}
