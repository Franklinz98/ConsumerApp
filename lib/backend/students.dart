import 'dart:convert';
import 'dart:io';
import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/person_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'movil-api.herokuapp.com';

Future<List> fetchStudents(String dbId, String token) async {
  Uri uri = Uri.https(baseUrl, '$dbId/students');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    List<PersonData> _students = [];
    var body = json.decode(response.body);
    body.forEach((courseJson) {
      _students.add(PersonData.fromJson(courseJson));
    });
    return _students;
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    throw Exception(body['message']);
  } else {
    throw Exception('Failed to login User');
  }
}

Future<Person> fetchStudent(String dbId, int studentId, String token) async {
  Uri uri = Uri.http(baseUrl, '$dbId/students/$studentId');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    return Person.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    throw Exception(body['error']);
  } else {
    throw Exception('Failed to login User');
  }
}
