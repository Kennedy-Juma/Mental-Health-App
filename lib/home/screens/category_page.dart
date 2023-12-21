import 'package:flutter/material.dart';
import 'package:mental_health_app_ui/home/screens/career_consultant_list_screen.dart';
import 'package:mental_health_app_ui/home/widgets/bottom_sheet_header_title.dart';
import 'package:mental_health_app_ui/home/widgets/category_grid.dart';
import 'package:mental_health_app_ui/home/widgets/date.dart';
import 'package:mental_health_app_ui/home/widgets/exercise_tile.dart';
import 'package:mental_health_app_ui/home/widgets/greet.dart';
import 'package:mental_health_app_ui/ApiServices/APIService.dart';
import 'relationship_consultant_list_screen.dart';
import 'detail_screen.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Map<String, dynamic>> _data = [];
  ApiService? apiService;
  late int sub_exercise_id;
  late String sub_exercise;
  late String description;

  Future<void> _fetchData() async {
    try {
      final List<Map<String, dynamic>> responseData =
      await apiService!.availableConsultants();
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
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Greet(),
                  Date(),
                  SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.blueAccent,
                      blurRadius: 10,
                    ),
                  ],
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BottomSheetHeaderTitle(
                        titleText: 'Category',
                      ),
                      Expanded(
                        child: GridView.count(
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisCount: 2,
                          children: [
                            CategoryGrid(
                              category: 'Relationship',
                              color: Colors.purple.shade500,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RelationshipConsultantListScreen(
                                      category: 'Relationship',
                                    ),
                                  ),
                                );
                              },
                            ),
                            CategoryGrid(
                              category: 'Career',
                              color: Colors.blue.shade300,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CareerConsultantListScreen(
                                      category: 'Career',
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const BottomSheetHeaderTitle(
                        titleText: 'Available Consultants',
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _data.length,
                          itemBuilder: (context, index) {
                            sub_exercise_id = _data[index]['categoryId'];
                            if (sub_exercise_id == 2) {
                              sub_exercise = "Relationship";
                            }
                            if (sub_exercise_id == 3) {
                              sub_exercise = "Career";
                            }
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      exercise: _data[index]['name'],
                                      subExercise: sub_exercise,
                                      description: _data[index]['info'],
                                    ),
                                  ),
                                );
                              },
                              child: ExerciseTile(
                                exercise: _data[index]['name'],
                                subExercise: sub_exercise,
                                icon: Icons.people,
                                color: Colors.green,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
