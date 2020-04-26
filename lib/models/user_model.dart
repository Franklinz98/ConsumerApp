class User {
  String token;
  String username;
  String name;

  User({this.token, this.username, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
}
