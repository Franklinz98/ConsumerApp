import 'package:consumo_web/backend/students.dart';
import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:consumo_web/screens/widgets/course_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsContainer extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Widget content;
  final String title;
  final Function unauthorizedProtocol;

  DetailsContainer(
      {Key key,
      @required this.content,
      @required this.title,
      @required this.unauthorizedProtocol})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: this._scaffoldKey,
      backgroundColor: AppColors.alabaster,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.tundora,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          this.title,
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: AppColors.tundora,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: this.content,
      floatingActionButton: Visibility(
        visible: this.content.runtimeType == CourseDetails,
        child: FloatingActionButton(
          backgroundColor: AppColors.ocean_green,
          onPressed: () {
            CourseDetails cd = content;
            postStudent(cd.user.username, cd.courseId, cd.user.token).then(
              (student) {
                cd.courseDetailsState.addStudent(student);
              },
            ).catchError(
              (error) {
                if (error.toString() == 'Unauthorized') {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) {
                      this.unauthorizedProtocol();
                    },
                  );
                }
              },
            );
          },
          tooltip: 'Add',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
