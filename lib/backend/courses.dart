import 'dart:convert';
import 'dart:io';
import 'package:consumo_web/models/course_data.dart';
import 'package:consumo_web/models/course_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'movil-api.herokuapp.com';

Future<List> fetchCourses(String dbId, String token) async {
  Uri uri = Uri.https(baseUrl, '$dbId/courses');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    List<CourseData> _courses = [];
    var body = json.decode(response.body);
    body.forEach((courseJson) {
      _courses.add(CourseData.fromJson(courseJson));
    });
    return _courses;
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body)[0];
    throw Exception(body['message']);
  } else {
    throw Exception('Failed to login User');
  }
}

Future<Course> fetchCourse(String dbId, int courseId, String token) async {
  Uri uri = Uri.http(baseUrl, '$dbId/courses/$courseId');
  final http.Response response = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    return Course.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    throw Exception(body['error']);
  } else {
    throw Exception('Failed to login User');
  }
}

Future<CourseData> postCourse(String dbId, String token) async {
  Uri uri = Uri.http(baseUrl, '$dbId/courses');
  final http.Response response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: "Bearer " + token,
    },
  );
  if (response.statusCode == 200) {
    return CourseData.fromJson(json.decode(response.body));
  } else if (response.statusCode == 401) {
    Map<String, dynamic> body = json.decode(response.body);
    throw Exception(body['error']);
  } else {
    throw Exception('Failed to login User');
  }
}
