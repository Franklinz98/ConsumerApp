import 'dart:convert';
import 'dart:io';
import 'package:consumo_web/models/user_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'movil-api.herokuapp.com';

Future<User> login(String email, String password) async {
  Uri uri = Uri.https(baseUrl, 'signin');
  final http.Response response = await http.post(
    uri,
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
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    throw Exception(body['message']);
  } else {
    throw Exception('Failed to login User');
  }
}

// SignUp request
Future<User> signUp(
    String email, String password, String username, String name) async {
  Uri uri = Uri.https(baseUrl, 'signup');
  final http.Response response = await http.post(
    uri,
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
  } else if (response.statusCode == 409) {
    throw Exception(response.body);
  } else {
    throw Exception('Failed to register user');
  }
}

// Check token request
Future<bool> checkToken(String token) async {
  Uri uri = Uri.https(baseUrl, 'check/token');
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> body = json.decode(response.body);
    bool isValid = body['valid'];
    return isValid;
  } else {
    throw Exception('Failed to register user');
  }
}

// Reset Database
Future<bool> resetDB(String dbId, String token) async {
  Uri uri = Uri.https(baseUrl, '$dbId/restart');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> body = json.decode(response.body);
    bool isValid = body['result'];
    return isValid;
  } else {
    throw Exception('Failed to restart DB');
  }
}
