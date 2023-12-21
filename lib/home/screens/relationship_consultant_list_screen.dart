// relationship_consultant_list_screen.dart

import 'package:flutter/material.dart';

import '../../ApiServices/APIService.dart';
import '../widgets/exercise_tile.dart';
import 'detail_screen.dart';
import 'notification/components/defaultAppBar.dart';
import 'notification/components/defaultBackButton.dart';

class RelationshipConsultantListScreen extends StatefulWidget {
   final String category;
  const RelationshipConsultantListScreen({Key? key,required this.category}) : super(key: key);

  @override
  _ConsultantListPageState createState() => _ConsultantListPageState();
}

class _ConsultantListPageState extends State<RelationshipConsultantListScreen> {

  List<Map<String, dynamic>> _data = [];
  ApiService? apiService;

  Future<void> _fetchData() async {
    try {
      final List<Map<String, dynamic>> responseData =
      await apiService!.relationshipConsultants();
      setState(() {
        _data = responseData;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    apiService = ApiService(context);
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    String category = widget.category;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const DefaultAppBar(
        title: 'Career Consultants',
        child: DefaultBackButton(),
      ),
      body: Expanded(
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {


            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(
                          exercise: _data[index]['name'],
                          subExercise: "Relationship",
                          description: _data[index]['info'],
                        ),
                  ),
                );
              },
              child: ExerciseTile(
                exercise: _data[index]['name'],
                subExercise: "Relationship",
                icon: Icons.people,
                color: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}
