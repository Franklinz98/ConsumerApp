import 'dart:collection';

import 'package:consumo_web/models/course_model.dart';
import 'package:consumo_web/models/person_model.dart';
import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  int listView = 0;
  String title = "Cursos";
  List<Person> _professors = [];
  List<Person> _students = [];
  List<Course> _courses = [];

  UnmodifiableListView<Person> get professors =>
      UnmodifiableListView(_professors);
  UnmodifiableListView<Person> get students => UnmodifiableListView(_students);
  UnmodifiableListView<Course> get courses => UnmodifiableListView(_courses);

  void changeList(int k, List list) {
    listView = k;
    switch (k) {
      case 1:
        title = "Profesores";
        break;
      case 2:
        title = "Estudiantes";
        break;
      default:
        _courses = list;
        title = "Cursos";
        break;
    }
    // notifyListeners();
  }
}
