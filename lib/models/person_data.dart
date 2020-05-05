class PersonData {
  final int id;
  final String name;
  final String username;
  final String email;

  const PersonData({this.id, this.name, this.username, this.email});

  factory PersonData.fromJson(Map<String, dynamic> json) {
    final personJson = json['person'];
    return PersonData(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

}
