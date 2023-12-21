import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:mental_health_app_ui/home/screens/home_page.dart';
import 'package:mental_health_app_ui/signin/signin.dart';
import '../home/bloc/home_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {

  HomeBloc? _homeBloc;

  HomeBloc? get homeBloc => _homeBloc;

  void disposeHomeBloc() => _homeBloc?.close();

  void setHomeBloc(HomeBloc bloc) => _homeBloc = bloc;

  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  final BuildContext context;

  ApiService(this.context);

  //check session status
  Future<void> checkSessionStatus() async {
    final lastLoginTimestampStr = await _storage.read(key: 'last_login_timestamp');

    if (lastLoginTimestampStr != null) {
      final lastLoginTimestamp = DateTime.parse(lastLoginTimestampStr);
      final currentTimestamp = DateTime.now();

      final sessionDuration = currentTimestamp.difference(lastLoginTimestamp).inSeconds.abs();

      if (sessionDuration >= 3600) {
        await deleteStoredDetails();
        logout();
      }
    }
  }


  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'access_token');
  }

  Future<bool> deleteStoredDetails() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: 'access_token');
      await storage.delete(key: 'user_email');
      await storage.delete(key: 'last_login_timestamp');
      return true;
    } catch (error) {
      print('Error deleting access token: $error');
      return false;
    }
  }

  //logout
  Future<void> logout() async {
    final isDeleted = await deleteStoredDetails();
    if (isDeleted) {

     Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SignIn())
      );
     disposeHomeBloc();
    } else {
      print('Failed to delete access token. Logout may not be complete.');
    }
  }

  Future<String?> getUserEmail() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'user_email');
  }

  //sign in
  Future<void> login(String username, String password) async {
    final response = await http.post(
        Uri.parse('http://localhost:5249/api/Account/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
        }));

    if (response.statusCode == 200) {
      final jsonObject = jsonDecode(response.body);
      final String accessToken = jsonObject['token'];
      final String expiration = jsonObject['expiration'];

      await _storage.write(key: 'access_token', value: accessToken);
      await _storage.write(key: 'last_login_timestamp', value: expiration);


      //HomeBloc homebloc = BlocProvider.of<HomeBloc>(context);
      final HomeBloc homeBloc = HomeBloc();
      setHomeBloc(homeBloc);
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => homeBloc,
                child:  HomePage(),
              )
          )
      );
    }
  }

  //Share Mood
  Future<void> shareMood(String description) async {
    final accessToken = await getAccessToken();
    String? userEmail = await getUserEmail();
    final response = await http.post(
        Uri.parse('http://localhost:5249/api/Mood'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{
          'description': description,
          'userId': userEmail
        }));

    if (response.statusCode == 200) {
      print("Success");
    } else {
      print("failure");
    }
  }

  //Get Moods
  Future<List<Map<String, dynamic>>> myMoods() async {
    final accessToken=await getAccessToken();
    try {
      final response = await http
          .get(Uri.parse('http://localhost:5249/api/Mood'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData is List) {
          // Filter and cast items to Map<String, dynamic>
          final List<Map<String, dynamic>> mymoods = responseData
              .whereType<Map<String, dynamic>>()
              .toList();
          return mymoods;
        } else {
          throw Exception('API response is not a list');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch moods');
    }
  }


  //Get Available Consultants
  Future<List<Map<String, dynamic>>> availableConsultants() async {
    final accessToken=await getAccessToken();
    try {
      final response = await http
          .get(Uri.parse('http://localhost:5249/api/Consultant/active-consultants'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<Map<String, dynamic>> activeConsultants = responseData
              .whereType<Map<String, dynamic>>()
              .toList();
          return activeConsultants;
        } else {
          throw Exception('API response is not a list');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch active consultants');
    }
  }

  //Get relationship Consultants
  Future<List<Map<String, dynamic>>> relationshipConsultants() async {
    final accessToken=await getAccessToken();
    try {
      final response = await http
          .get(Uri.parse('http://localhost:5249/api/Consultant/relationship-consultants'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<Map<String, dynamic>> activeConsultants = responseData
              .whereType<Map<String, dynamic>>()
              .toList();
          return activeConsultants;
        } else {
          throw Exception('API response is not a list');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch relationship consultants');
    }
  }

  //Get career Consultants
  Future<List<Map<String, dynamic>>> careerConsultants() async {
    final accessToken=await getAccessToken();
    try {
      final response = await http
          .get(Uri.parse('http://localhost:5249/api/Consultant/career-consultants'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<Map<String, dynamic>> activeConsultants = responseData
              .whereType<Map<String, dynamic>>()
              .toList();
          return activeConsultants;
        } else {
          throw Exception('API response is not a list');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch relationship consultants');
    }
  }

  //Get blogs
  Future<List<Map<String, dynamic>>> blogs() async {
    final accessToken=await getAccessToken();
    try {
      final response = await http
          .get(Uri.parse('http://localhost:5249/api/Exercise/blogs'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          });

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);

        if (responseData is List) {
          final List<Map<String, dynamic>> blogPosts = responseData
              .whereType<Map<String, dynamic>>()
              .toList();
          return blogPosts;
        } else {
          throw Exception('API response is not a list');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch blogs');
    }
  }

  //sign up
  Future<void> signUp(String fullName, String phoneNumber,
      String email, String password) async {
    final response = await http.post(
        Uri.parse('http://localhost:5249/api/Account/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SignIn())
      );
    }


  }

  //retrieve profile picture
  Future<Uint8List> retrieveProfilePicture(String id) async {
    try {
      final accessToken=await getAccessToken();
      final response = await http.get(
        Uri.parse('http://localhost:5249/api/Documents/get/$id'),
        headers: <String,String>{
          'Authorization': 'Bearer $accessToken',
        }
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        String base64Data = responseData['base64Data'];
        Uint8List imageBytes = Uint8List.fromList(base64.decode(base64Data));

        return imageBytes;
      } else {
        print('Failed to retrieve profile picture: ${response.statusCode}');
        throw Exception('Failed to retrieve profile picture');
      }
    } catch (error) {
      print('Error retrieving profile picture: $error');
      throw Exception('Error retrieving profile picture');
    }
  }

  //get user profile
  Future<Map<String, dynamic>> getUserProfile(String userEmail) async {
    //final prefs = await SharedPreferences.getInstance();
    //final String? accessToken = prefs.getString('access_token');

    final accessToken=await getAccessToken();
    try {
      final response = await http.get(
        Uri.parse('http://localhost:5249/api/Account/users/$userEmail'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> profileData = jsonDecode(response.body);
        return profileData;
      } else {
        throw Exception('Failed to load user profile data');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to fetch user profile');
    }
  }

  // Edit user profile
  Future<void> editUserProfile(String fullName,String phoneNumber, String email) async {
    final accessToken=await getAccessToken();
    try {
      final response = await http.post(
          Uri.parse('http://localhost:5249/api/Account/edit-profile'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode(<String, dynamic>{
            'fullName': fullName,
            'phoneNumber': phoneNumber,
            'email': email,
          })
      );

      if (response.statusCode == 200) {} else {
        throw Exception('Failed to update user profile');
      }
    } catch (error) {
      print(error);
      throw Exception('Failed to edit user profile');
    }
  }

  //profile pic upload
  Future<void> uploadImage(Uint8List imageBytes, String filename) async {
    final accessToken=await getAccessToken();
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5249/api/Documents/upload'),

    );

    var multipartFile = http.MultipartFile.fromBytes(
      'files',
      imageBytes,
      filename: "testing.jpg",
    );
    request.files.add(multipartFile);
    request.headers['Authorization'] = 'Bearer $accessToken';

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  //change password
  Future<void> changePassword(String oldPassword, String newPassword,
      String email) async {
    final accessToken=await getAccessToken();
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5249/api/Account/change-password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(<String, dynamic>{
          'oldPassword': oldPassword,
          'newPassword': newPassword,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
         showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Success!'),
              content: Text('Password changed successfully.'),
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
      else {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Error!'),
              content: Text('An error occurred while changing password'),
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
    } catch (error) {
      print(error);
    }
  }
}
