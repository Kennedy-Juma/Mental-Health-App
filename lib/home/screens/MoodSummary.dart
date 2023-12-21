import 'package:flutter/material.dart';

import 'detail_screen.dart';

class MoodSummaryPage extends StatelessWidget {
  var daysmood;
  final String dayOfWeek;
  final List<Map<String, dynamic>> moodsForDay;

  MoodSummaryPage({
    required this.dayOfWeek,
    required this.moodsForDay,
  });

  Future<void> _showSummaryPopup(
      BuildContext context,
      Map<String, dynamic> mood,
      ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mood Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mood: ${mood['moodName']}'),
              Text('Date: ${mood['dateCaptured']}'),
              // Add other details as needed
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAverageMoodPopup(BuildContext context) async {
    if (moodsForDay.isEmpty) {
      print('No moods available.');
      return; // No moods, don't calculate average
    }

    // Extract mood scores from the list
    final moodScores = moodsForDay
        .map<double>((mood) {
      final moodScore = mood['score'] ?? 0.0;
      print('Mood Score: $moodScore');
      return moodScore.toDouble();
    })
        .toList();

    final totalScore = moodScores.reduce((value, element) => value + element);
    final averageScore = totalScore / moodsForDay.length;
    if (averageScore > 0 && averageScore <= 1) {
      daysmood = 'Badly';
    } else if (averageScore > 1 && averageScore <= 2) {
      daysmood = 'Fine';
    } else if (averageScore > 2 && averageScore <= 3) {
      daysmood = 'Well';
    } else if (averageScore >= 4) {
      daysmood = 'Excellent';
    }


    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Summary for $dayOfWeek'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your Average Score: ${averageScore.toStringAsFixed(2)}'),
              Text('Your Days Mood: $daysmood'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  String _extractDate(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final String formattedDate = '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    return formattedDate;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary for $dayOfWeek'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            color: Colors.blue,
            onPressed: () {
              _showAverageMoodPopup(context);
            },
          ),
          const Text(
            'More Info',
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: moodsForDay.length,
              itemBuilder: (context, index) {
                final mood = moodsForDay[index];
                return ListTile(

                  title: Text(mood['description']),
                  subtitle: Text('Date: ${_extractDate(mood['dateCaptured'])}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
