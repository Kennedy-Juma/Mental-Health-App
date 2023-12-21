import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../ApiServices/APIService.dart';
import '../../../constant.dart';
import '../../../utils/image_upload.dart';
import '../notification/components/defaultAppBar.dart';
import '../notification/components/defaultBackButton.dart';


class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  Uint8List? _image;
  String? _name;
  Uint8List? _profileImage;

  void selectImage() async {
    final result = await pickImage(ImageSource.gallery);

    if (result != null) {
      Uint8List img = result['imageBytes'];
      String filename = result['filename'];

      setState(() {
        _image = img;
        _name = filename;
      });

      if (_image != null) {
        ApiService(context).uploadImage(_image!, _name!);
      }
    }
  }


  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String userEmail = '';
  Map<String, dynamic> userProfile = {};

  Future<void> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail') ?? '';
    });
  }

  Future<Map<String, dynamic>> getUserProfileData() async {
    try {
      final profileData = await ApiService(context).getUserProfile(userEmail);
      return profileData;
    } catch (error) {
      throw error;
    }
  }

  Future<void> retrieveProfileImage() async {
    try {
      final imageBytes = await ApiService(context).retrieveProfilePicture(userEmail);
      setState(() {
        _profileImage = imageBytes;
      });
    } catch (error) {
      print('Error retrieving profile image: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserEmail().then((_) {
      getUserProfileData().then((data) {
        setState(() {
          userProfile = data;
          phoneController.text = userProfile['phone'];
          fullNameController.text = userProfile['fullName'];

          retrieveProfileImage();
        });
      }).catchError((error) {
        print('Error fetching user profile data: $error');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: 'Edit Profile',
        child: DefaultBackButton(),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        //selectImage();
                      },
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _image != null
                                ? MemoryImage(_image!)
                            :_profileImage!=null
                            ?
                            MemoryImage(_profileImage!)
                                : AssetImage(profile) as ImageProvider
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.blue,
                        ),
                       child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField("Full Name", fullNameController, false, (value) {
                userProfile['fullName'] = value;
              }),
              buildTextField("Phone Number", phoneController, false, (value) {
                userProfile['phone'] = value;
              }),
              buildTextField("Email Address", TextEditingController(text: userProfile['email']), false, (value) {
              }),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      primary: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> updatedProfile = {
                        'fullName': fullNameController.text,
                        'phoneNumber': phoneController.text,
                        'email': userEmail,
                      };

                      try {
                        await ApiService(context).editUserProfile(
                          updatedProfile['fullName'],
                          updatedProfile['phoneNumber'],
                          updatedProfile['email'],
                        );

                        setState(() {
                          userProfile = updatedProfile;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text('Profile Updated'),
                              content: Text('Your profile has been updated successfully.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } catch (error) {
                        print('Error updating profile: $error');
                        showDialog(
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('An error occurred while updating the profile.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  ),



                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller, bool isPasswordTextField, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        onChanged: onChanged,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.blue,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
        ),
      ),
    );
  }
}
