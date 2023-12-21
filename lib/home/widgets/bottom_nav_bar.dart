import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app_ui/home/bloc/home_bloc.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                IndexChangedEvent(
                  selectedIndex: 0,
                ),
              );
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: IconButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                IndexChangedEvent(
                  selectedIndex: 1,
                ),
              );
            },
            icon: const Icon(
              Icons.message,
            ),
          ),
        ),
      ],
    );
  }
}
