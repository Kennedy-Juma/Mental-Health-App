

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app_ui/ApiServices/APIService.dart';

import '../signin/signin.dart';

class AuthInterceptor implements InterceptorContract {
  final BuildContext? context;

  AuthInterceptor({  this.context});

  Future<String?> getAccessToken() async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: 'access_token');
  }

  void navigateToSignIn(BuildContext? context) {
    if (context != null) {
      ApiService(context).logout();
    } else {
      print('Warning: Context is null, unable to navigate to sign-in.');
    }
  }


/*  void navigateToSignIn(BuildContext context) {
    ApiService(context).logout();

  }*/



  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async{
    final accessToken=await getAccessToken();

    final newRequest = request.copyWith(headers: {
      'Authorization': 'Bearer $accessToken',
    });
    return newRequest;
  }

  @override
  Future<http.BaseResponse> interceptResponse({required http.BaseResponse response})async {
    print('Response status code: ${response.statusCode}');
    if(response.statusCode==401){
      navigateToSignIn(context!);
    }
    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() async {
    return true;
  }

  @override
  Future<bool> shouldInterceptResponse() async{
  return true;
  }

}
