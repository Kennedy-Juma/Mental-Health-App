

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app_ui/ApiServices/APIService.dart';
import 'package:mental_health_app_ui/home/bloc/home_bloc.dart';
import 'package:mental_health_app_ui/home/screens/home_page.dart';
import 'package:mental_health_app_ui/signin/signin.dart';
import 'package:mental_health_app_ui/utils/session_listener.dart';

import 'home/screens/account/pravacy_page.dart';
import 'home/screens/account/terms_and_conditions_page.dart';


void main() {

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

   final _navKey = GlobalKey<NavigatorState>();



  @override
  Widget build(BuildContext context) {
    return SessionTimeoutListener(
      //key: _navKey,
      duration: const Duration(seconds: 3600),
      onTimeOut: () {
        ApiService(_navKey.currentState!.context).checkSessionStatus();
      },
      child: MaterialApp(
        navigatorKey: _navKey,
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => HomeBloc(),
          child: const TermsAndConditionsPage(),
        ),
      ),
    );
  }
}
