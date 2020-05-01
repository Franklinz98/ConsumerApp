class User {
  String token;
  String username;
  String name;
  String email;

  User({this.token, this.username, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
    );
  }
}
