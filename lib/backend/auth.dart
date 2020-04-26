import 'dart:convert';
import 'dart:developer';
import 'package:consumo_web/models/user_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://movil-api.herokuapp.com';

Future<User> login(String email, String password) async {
  final http.Response response = await http.post(
    baseUrl + '/signin',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to login User');
  }
}

Future<User> signUp(
    String email, String password, String username, String name) async {
  final http.Response response = await http.post(
    baseUrl + '/signup',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
      'username': email,
      'name': name,
    }),
  );
  if (response.statusCode == 200) {
    return User.fromJson(json.decode(response.body));
  } else {
    return null;
  }
}
