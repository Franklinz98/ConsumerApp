import 'package:consumo_web/models/course_model.dart';
import 'package:consumo_web/models/person_model.dart';
import 'package:consumo_web/screens/widgets/listitem.dart';
import 'package:consumo_web/screens/widgets/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CourseDetails extends StatelessWidget {
  final Course course;

  const CourseDetails({Key key, @required this.course})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text(
            course.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Color(0xff444444),
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
            content: course.professor.username + '\n' + course.professor.email,
            leading: Container(
              height: 48.00,
              width: 48.00,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://api.adorable.io/avatars/285/' +
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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                Person student = course.students[index];
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
      ),
    );
  }
}
