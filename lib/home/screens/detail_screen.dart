import 'package:flutter/material.dart';
import 'package:mental_health_app_ui/home/screens/consultation_page.dart';
import '../../theme/extention.dart';

import '../../model/doctor_model.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';
import '../../widgets1/progress_widget.dart';
import '../../widgets1/rating_star_widget.dart';

class DetailScreen extends StatefulWidget {
  final String exercise;
  final String subExercise;
  final String description;

  DetailScreen({
    Key? key,
    required this.exercise,
    required this.subExercise,
    required this.description,
  }) : super(key: key);


  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailScreen> {
  late String exercise;
  late String subExercise;
  late String description;

  @override
  void initState() {
    exercise = widget.exercise;
    subExercise = widget.subExercise;
    description = widget.description;
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(
          color: Theme.of(context).primaryColor,
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.asset("assets/images/profile-avatar-resized.jpg"),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: AppTheme.fullHeight(context) * .5,
                  padding: const EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 16,
                  ), //symmetric(horizontal: 19, vertical: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                exercise,
                                style: titleStyle,
                              ),


                            ],
                          ),
                          subtitle: Text(
                            subExercise,
                            style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),

                        Text("About", style: titleStyle).vP16,
                        Text(
                          description,
                          style: TextStyles.body.subTitleColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: LightColor.green.withAlpha(150),
                              ),
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              width: 10,
                            ),

                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppointmentPage(exercise: exercise,)
                                    ),
                                  );
                                },
                                child: Text(
                                  'Consult $exercise',
                                  style: TextStyles.titleNormal.white,
                                ),
                              ),
                            ),
                          ],
                        ).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
