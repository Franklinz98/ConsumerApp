import 'dart:collection';

import 'package:consumo_web/models/course_data.dart';
import 'package:consumo_web/models/person_data.dart';
import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  int _listView = 0;
  String title = "Cursos";
  List<PersonData> _professors = [];
  List<PersonData> _students = [];
  List<CourseData> _courses = [];

  UnmodifiableListView<PersonData> get professors =>
      UnmodifiableListView(_professors);
  UnmodifiableListView<PersonData> get students =>
      UnmodifiableListView(_students);
  UnmodifiableListView<CourseData> get courses =>
      UnmodifiableListView(_courses);
  int get view => _listView;

  void changeList(List list) {
    switch (_listView) {
      case 1:
        _professors = list;
        title = "Profesores";
        break;
      case 2:
        _students = list;
        title = "Estudiantes";
        break;
      default:
        _courses = list;
        title = "Cursos";
        break;
    }
  }

  set view(int index) {
    _listView = index;
    switch (index) {
      case 1:
        title = "Profesores";
        break;
      case 2:
        title = "Estudiantes";
        break;
      default:
        title = "Cursos";
        break;
    }
  }

  void addCourse(CourseData course) {
    _courses.add(course);
    notifyListeners();
  }
}
