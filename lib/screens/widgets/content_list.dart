import 'package:consumo_web/models/course_data.dart';
import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:consumo_web/screens/content/details_container.dart';
import 'package:consumo_web/screens/widgets/course_details.dart';
import 'package:consumo_web/screens/widgets/listitem.dart';
import 'package:consumo_web/screens/widgets/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ContentList extends StatefulWidget {
  final scaffoldKey;
  final ListProvider model;
  final User user;

  const ContentList(
      {Key key, this.scaffoldKey, @required this.model, @required this.user})
      : super(key: key);

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  Widget _listView(ListProvider model) {
    switch (model.view) {
      case 1:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            PersonData professor = model.professors[index];
            return ListItem(
              title: professor.name,
              content: professor.username + '\n' + professor.email,
              leading: Container(
                height: 48.00,
                width: 48.00,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://api.adorable.io/avatars/285/' +
                        professor.email),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              onPressed: () {
                // TODO navigate and fetch professor
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsContainer(
                        content: PersonDetails(
                            personId: professor.id, type: 0, user: widget.user),
                        title: 'Profesor'),
                  ),
                );
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<ListProvider>.value(
                      value: model,
                      child: DetailsContainer(
                          content: PersonDetails(
                            person: professor,
                          ),
                          title: 'Profesor'),
                    ),
                  ),
                ); */
              },
            );
          },
          itemCount: model.professors.length,
        );
      case 2:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            PersonData student = model.students[index];
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
                        'https://api.adorable.io/avatars/285/' + student.email),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              onPressed: () {
                // TODO Navigate and fetch student
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsContainer(
                        content: PersonDetails(
                            personId: student.id, type: 1, user: widget.user),
                        title: 'Estudiante'),
                  ),
                );
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<ListProvider>.value(
                      value: model,
                      child: DetailsContainer(
                          content: PersonDetails(
                            person: student,
                          ),
                          title: 'Estudiante'),
                    ),
                  ),
                ); */
              },
            );
          },
          itemCount: model.students.length,
          addAutomaticKeepAlives: false,
        );
      default:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            CourseData course = model.courses[index];
            return ListItem(
              title: course.name,
              content: course.professorName +
                  '\n' +
                  course.students.toString() +
                  ' Estudiantes',
              leading: Container(
                height: 48.00,
                width: 48.00,
                child: Icon(LineIcons.university),
                alignment: Alignment.center,
              ),
              onPressed: () {
                // TODO navigate and fetch course
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsContainer(
                        content: CourseDetails(
                            courseId: course.id, user: widget.user),
                        title: 'Curso'),
                  ),
                );
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider<ListProvider>.value(
                      value: model,
                      child: DetailsContainer(
                          content: CourseDetails(
                            course: course,
                          ),
                          title: 'Curso'),
                    ),
                  ),
                ); */
              },
            );
          },
          itemCount: model.courses.length,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _listView(widget.model);
  }
}
