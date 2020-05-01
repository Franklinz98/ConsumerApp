import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  bool _authState = false;
  String _name = "John Doe";
  String _email = "john.doe@example.com";
  String _username = "john.doe";
  String _token = "null";

  bool get isLogged => _authState;
  String get name => _name;
  String get email => _email;
  String get username => _username;
  String get token => _token;

  void connect(String name, String email, String username, String token) {
    _name = name;
    _email = email;
    _username = username;
    _token = token;
    _authState = true;
    notifyListeners();
  }

  void disconnect() {
    _name = "John Doe";
    _email = "john.doe@example.com";
    _username = "john.doe";
    _token = "null";
    _authState = false;
    notifyListeners();
  }
}
