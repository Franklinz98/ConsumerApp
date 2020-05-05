import 'dart:convert';
import 'dart:io';
import 'package:consumo_web/models/person_data.dart';
import 'package:consumo_web/models/person_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'movil-api.herokuapp.com';

Future<List> fetchProfessors(String dbId, String token) async {
  Uri uri = Uri.https(baseUrl, '$dbId/professors');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    List<PersonData> _professors = [];
    var body = json.decode(response.body);
    body.forEach((courseJson) {
      _professors.add(PersonData.fromJson(courseJson));
    });
    return _professors;
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    throw Exception(body['message']);
  } else {
    throw Exception('Failed to login User');
  }
}

Future<Person> fetchProfessor(String dbId, int professorId, String token) async {
  Uri uri = Uri.http(baseUrl, '$dbId/professors/$professorId');
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