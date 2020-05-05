class CourseData {
  final int id;
  final String name;
  final String professorName;
  final int students;

  const CourseData({this.id, this.name, this.professorName, this.students});

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      id: json['id'],
      name: json['name'],
      professorName: json['professor'],
      students: json['students'],
    );
  }
}
