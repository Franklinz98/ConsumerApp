import 'package:consumo_web/models/person_model.dart';

class Course {
  final id;
  final String name;
  final Person professor;
  final List<Person> students;

  const Course({this.id, this.name, this.professor, this.students});

  factory Course.fromJson(Map<String, dynamic> json) {
    final Person _professor = Person.fromJson(json['professor']);
    final List<Person> _students = [];
    List<dynamic> studentList = json['students'];
    studentList.forEach((studentJson) {
      _students.add(Person.fromJson(studentJson));
    });

    return Course(
      id: json['id'],
      name: json['name'],
      professor: _professor,
      students: _students,
    );
  }
}
