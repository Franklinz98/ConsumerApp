import 'package:consumo_web/backend/courses.dart';
import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/course_model.dart';
import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/screens/widgets/listitem.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CourseDetails extends StatefulWidget {
  final int courseId;
  final User user;

  CourseDetails({Key key, @required this.courseId, @required this.user})
      : super(key: key);

  _CourseDetailsState courseDetailsState = _CourseDetailsState();

  @override
  _CourseDetailsState createState() => courseDetailsState;
}

class _CourseDetailsState extends State<CourseDetails> {
  Future<Course> futureCourse;
  Course course;

  @override
  void initState() {
    super.initState();
    futureCourse =
        fetchCourse(widget.user.username, widget.courseId, widget.user.token);
  }

  void addStudent(PersonData student) {
    if (course != null) {
      setState(() {
        course.addStudent(student);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Course>(
      future: futureCourse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            course = snapshot.data;
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              course.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                color: Color(0xff444444),
                              ),
                            ),
                            Text(
                              'ID: ${widget.courseId}',
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Color(0xff444444),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        leading: Icon(LineIcons.user),
                        title: Text(
                          "Profesor",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ListItem(
                        title: course.professor.name,
                        content: course.professor.username +
                            '\n' +
                            course.professor.email,
                        leading: Container(
                          height: 48.00,
                          width: 48.00,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://api.adorable.io/avatars/285/' +
                                      course.professor.email),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(LineIcons.users),
                        title: Text(
                          "Estudiantes",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding:
                        EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                    itemBuilder: (_, index) {
                      PersonData student = course.students[index];
                      return ListItem(
                        title: student.name,
                        content: student.username + '\n' + student.email,
                        leading: Container(
                          height: 48.00,
                          width: 48.00,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://api.adorable.io/avatars/285/' +
                                      student.email),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                    itemCount: course.students.length,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            Navigator.pop(context, 'Unauthorized');
          }
        }
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.ocean_green),
          ),
        );
      },
    );
  }
}
