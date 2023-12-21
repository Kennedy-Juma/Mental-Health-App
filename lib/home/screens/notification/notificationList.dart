import 'dart:convert';

import '../../../ApiServices/APIService.dart';
import '../MoodSummary.dart';
import 'components/defaultBackButton.dart';
import 'package:flutter/material.dart';
import 'components/defaultAppBar.dart';


class MyMoodList extends StatefulWidget {
  MyMoodList({Key? key}) : super(key: key);

  @override
  _MyMoodListState createState() => _MyMoodListState();
}

class _MyMoodListState extends State<MyMoodList> {
  static const kWhiteColor = Color(0xFFFFFFFF);
  ApiService? apiService;
  Map<String, List<Map<String, dynamic>>> groupedMoods = {};

  Future<void> _fetchData() async {
    try {
      final List<Map<String, dynamic>> responseData =
      await apiService!.myMoods();

      // Group moods by day
      groupedMoods = _groupMoodsByDay(responseData);

      setState(() {
        // No need to set _data anymore
      });
    } catch (error) {
      print(error);
    }
  }

  Map<String, List<Map<String, dynamic>>> _groupMoodsByDay(
      List<Map<String, dynamic>> moods) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (final mood in moods) {
      final moodDate = DateTime.parse(mood['dateCaptured']);
      final dayOfWeek = getDayOfWeek(moodDate);

      if (!grouped.containsKey(dayOfWeek)) {
        grouped[dayOfWeek] = [];
      }

      grouped[dayOfWeek]!.add(mood);
    }

    return grouped;
  }

  String getDayOfWeek(DateTime date) {
    final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return weekdays[date.weekday - 1];
  }

  @override
  void initState() {
    super.initState();
    apiService = ApiService(context);
    _fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: const DefaultAppBar(
        title: 'My Moods',
        child: DefaultBackButton(),
      ),
      body: ListView.builder(
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: groupedMoods.length,
        itemBuilder: (context, index) {
          final dayOfWeek = groupedMoods.keys.elementAt(index);
          final moodsForDay = groupedMoods[dayOfWeek]!;

          return Column(
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dayOfWeek),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoodSummaryPage(
                              dayOfWeek: dayOfWeek,
                              moodsForDay: moodsForDay,
                            ),
                          ),
                        );
                      },
                      child: Text('Summary'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

