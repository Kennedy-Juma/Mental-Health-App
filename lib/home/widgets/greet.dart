import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app_ui/constants.dart';
import 'package:mental_health_app_ui/home/bloc/home_bloc.dart';
import 'package:mental_health_app_ui/home/widgets/notification_icon.dart';

import '../../ApiServices/APIService.dart';

class Greet extends StatefulWidget {
  const Greet({Key? key}) : super(key: key);

  @override
  _GreetPage createState() => _GreetPage();
}


class _GreetPage extends State<Greet> {
  String _email = "";
  ApiService? apiService;


  Future<void> getUserEmail() async {
    try {
      final String? email =
      await apiService!.getUserEmail();
      setState(() {
        _email = email!;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    apiService = ApiService(context);
    getUserEmail();
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return Text(
                'Welcome! $_email ${state.mood}',
                style: greetText,
                softWrap: true,
              );
            },
          ),
        ),
        const NotificationIcon(),
      ],
    );
  }

}
