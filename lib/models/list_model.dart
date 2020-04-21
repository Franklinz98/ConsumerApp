import 'dart:collection';

import 'package:consumo_web/models/course_model.dart';
import 'package:consumo_web/models/person_model.dart';
import 'package:flutter/material.dart';

class ListModel extends ChangeNotifier {
  int listView = 0;
  String title = "Cursos";
  final List<Person> _professors = [
    Person(
        9,
        1,
        'Aida Cruickshank',
        'Nick.Schowalter',
        '1987-03-31',
        'Arnulfo_Grady5@gmail.com',
        'Parker Pass',
        'East Mercedestown, Grenada',
        '(689) 983-2549')
  ];
  final List<Person> _students = [
    Person(
        6,
        1,
        'Trudie Cummings',
        'Carole.Schinner',
        '1989-08-02',
        'Jadon.Schmeler79@yahoo.com',
        'Brakus Cove',
        'West Danika, Jordan',
        '(229) 861-1187'),
    Person(
        7,
        1,
        'Kendra Wyman',
        'Alanis.Durgan',
        '1988-05-17',
        'Trever_Weber84@gmail.com',
        'Schneider Station',
        'South Magdalenaton, Vietnam',
        '1-793-857-4787'),
    Person(
        8,
        1,
        'Luna Murray',
        'Robbie42',
        '1999-01-31',
        'Elissa_Mante88@hotmail.com',
        'Eino Glens',
        'East Reesestad, French Polynesia',
        '825-400-7077 x892'),
  ];
  final List<Course> _courses = [
    Course(
        1,
        "HACKING BACK-END MATRIX",
        Person(
            9,
            1,
            'Aida Cruickshank',
            'Nick.Schowalter',
            '1987-03-31',
            'Arnulfo_Grady5@gmail.com',
            'Parker Pass',
            'East Mercedestown, Grenada',
            '(689) 983-2549'),
        [
          Person(
              6,
              1,
              'Trudie Cummings',
              'Carole.Schinner',
              '1989-08-02',
              'Jadon.Schmeler79@yahoo.com',
              'Brakus Cove',
              'West Danika, Jordan',
              '(229) 861-1187'),
          Person(
              7,
              1,
              'Kendra Wyman',
              'Alanis.Durgan',
              '1988-05-17',
              'Trever_Weber84@gmail.com',
              'Schneider Station',
              'South Magdalenaton, Vietnam',
              '1-793-857-4787'),
          Person(
              8,
              1,
              'Luna Murray',
              'Robbie42',
              '1999-01-31',
              'Elissa_Mante88@hotmail.com',
              'Eino Glens',
              'East Reesestad, French Polynesia',
              '825-400-7077 x892'),
        ])
  ];

  UnmodifiableListView<Person> get professors =>
      UnmodifiableListView(_professors);
  UnmodifiableListView<Person> get students => UnmodifiableListView(_students);
  UnmodifiableListView<Course> get courses => UnmodifiableListView(_courses);

  void changeList(int k) {
    listView = k;
    switch (k) {
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
    notifyListeners();
  }
}
