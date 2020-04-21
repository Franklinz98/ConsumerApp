import 'package:consumo_web/models/person_model.dart';

class Course {

  final id;
  final String name;
  final Person professor;
  final List<Person> students;

  const Course(this.id, this.name, this.professor, this.students);

}