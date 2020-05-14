import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/person_model.dart';

class Course {
  final String name;
  final PersonData professor;
  final List<PersonData> students;

  const Course({this.name, this.professor, this.students});

  factory Course.fromJson(Map<String, dynamic> json) {
    final List<PersonData> _students = [];
    List<dynamic> studentList = json['students'];
    studentList.forEach((studentJson) {
      _students.add(PersonData.fromJson(studentJson));
    });

    return Course(
      name: json['name'],
      professor: PersonData.fromJson(json['professor']),
      students: _students,
    );
  }

  void addStudent(PersonData student) {
    students.add(student);
  }
}
