class Person {
  final int id;
  final int courseId;
  final String name;
  final String username;
  final String birthday;
  final String email;
  final String address;
  final String location;
  final String phone;

  const Person({this.id, this.courseId, this.name, this.username, this.birthday,
      this.email, this.address, this.location, this.phone});

  factory Person.fromJson(Map<String, dynamic> json) {
    final personJson = json['person'];
    return Person(
      courseId: json['course_id'],
      id: personJson['id'],
      name: personJson['name'],
      username: personJson['username'],
      birthday: personJson['birthday'],
      email: personJson['email'],
      address: personJson['address_street'],
      location: '${personJson['address_city']}, ${personJson['address_country']}',
      phone: personJson['phone'],
    );
  }
}
