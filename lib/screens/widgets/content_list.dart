import 'package:consumo_web/models/course_model.dart';
import 'package:consumo_web/models/person_model.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:consumo_web/screens/content/details_container.dart';
import 'package:consumo_web/screens/widgets/course_detail.dart';
import 'package:consumo_web/screens/widgets/listitem.dart';
import 'package:consumo_web/screens/widgets/person_detail.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ContentList extends StatefulWidget {
  final scaffoldKey;
  final ListProvider model;

  const ContentList({Key key, this.scaffoldKey, @required this.model})
      : super(key: key);

  @override
  _ContentListState createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  @override
  void initState() {
    super.initState();
    // TODO fetch ContentList
  }

  Widget _listView(ListProvider model) {
    switch (model.listView) {
      case 1:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            Person professor = model.professors[index];
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
                Navigator.push(
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
                );
              },
            );
          },
          itemCount: model.professors.length,
        );
      case 2:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            Person student = model.students[index];
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
                Navigator.push(
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
                );
              },
            );
          },
          itemCount: model.students.length,
        );
      default:
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemBuilder: (_, index) {
            Course course = model.courses[index];
            return ListItem(
              title: course.name,
              content: course.professor.name +
                  '\n' +
                  course.students.length.toString() +
                  ' Estudiantes',
              leading: Container(
                height: 48.00,
                width: 48.00,
                child: Icon(LineIcons.university),
                alignment: Alignment.center,
              ),
              onPressed: () {
                Navigator.push(
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
                );
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
