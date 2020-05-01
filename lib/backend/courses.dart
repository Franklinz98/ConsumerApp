import 'dart:convert';
import 'dart:io';
import 'package:consumo_web/models/course_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'movil-api.herokuapp.com';

Future<List> fetchCourses(String dbId, String token, String page) async {
  Uri uri = Uri.https(baseUrl, '$dbId/courses', {
    'page': page,
  });
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    List<Course> _courses = [];
    Map<String, dynamic> body = json.decode(response.body);
    List<dynamic> courses = body['data'];
    courses.forEach((courseJson) {
      _courses.add(Course.fromJson(courseJson));
    });
    return [body['total'], body['page'], _courses];
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    throw Exception(body['message']);
  } else {
    throw Exception('Failed to login User');
  }
}
