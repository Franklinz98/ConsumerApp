import 'package:consumo_web/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  bool _authState = false;
  User _user = User(
      token: "null",
      username: "john.doe",
      name: "John Doe",
      email: "john.doe@example.com");

  User get user => _user;
  bool get isLogged => _authState;


  void connect(String name, String email, String username, String token) {
    _user = User(token: token, username: username, name: name, email: email);
    _authState = true;
    notifyListeners();
  }

  void disconnect() {
    _user = User(
        token: "null",
        username: "john.doe",
        name: "John Doe",
        email: "john.doe@example.com");
    _authState = false;
    notifyListeners();
  }
}
