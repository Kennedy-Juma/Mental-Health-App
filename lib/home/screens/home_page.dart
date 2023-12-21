import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mental_health_app_ui/ApiServices/APIService.dart';
import 'package:mental_health_app_ui/home/bloc/home_bloc.dart';
import 'package:mental_health_app_ui/home/screens/category_page.dart';
import 'package:mental_health_app_ui/home/widgets/bottom_nav_bar.dart';
import 'package:mental_health_app_ui/home/widgets/bottom_sheet_header_title.dart';
import 'package:mental_health_app_ui/home/widgets/date.dart';
import 'package:mental_health_app_ui/home/widgets/emoticon_card.dart';
import 'package:mental_health_app_ui/home/widgets/exercise_tile.dart';
import 'package:mental_health_app_ui/home/widgets/greet.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeBody createState() => _HomeBody();
}

class _HomeBody extends State<HomePage> {
  _HomeBody();

  List<Map<String, dynamic>> _data = [];
  ApiService? apiService;

  Future<void> _fetchData() async {
    try {
      final List<Map<String, dynamic>> responseData = await apiService!.blogs();
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
  void dispose() {
    super.dispose();
    BlocProvider.of<HomeBloc>(context).close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavBar(
            currentIndex: state.index,
          ),
          body: state.index == 0
              ? _HomeBodyContent(data: _data, apiService: apiService)
              : const CategoryPage(),
        );
      },
    );
  }
}

class _HomeBodyContent extends StatelessWidget {
  const _HomeBodyContent({Key? key, required this.data, required this.apiService}) : super(key: key);

  final List<Map<String, dynamic>> data;
  final ApiService? apiService;

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
                  SizedBox(height: 25.0),

                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'How do you feel?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.more_horiz,
                        size: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      EmoticonCard(
                        emoticonFace: '😔',
                        mood: 'Badly',
                      ),
                      EmoticonCard(
                        emoticonFace: '😊',
                        mood: 'Fine',
                      ),
                      EmoticonCard(
                        emoticonFace: '😁',
                        mood: 'Well',
                      ),
                      EmoticonCard(
                        emoticonFace: '😃',
                        mood: 'Excellent',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                        titleText: 'Your mental health fitness',
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: data.length, // Number of exercises
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ExerciseTile(
                                      exercise: data[index]['description'],
                                      subExercise: data[index]['description'],
                                      icon: Icons.favorite,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0), // Add some horizontal space
                                  ElevatedButton(
                                    onPressed: () async {
                                      var url = Uri.parse(data[index]['url']);
                                      if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
                                        throw 'cannot launch url';
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Read',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
