import 'dart:convert';
import 'dart:io';
import 'package:consumo_web/models/person_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://movil-api.herokuapp.com';

Future<Person> fetchStudent() async {
  final http.Response response = await http.get(
    baseUrl + '/user/students/6',
    headers: {
      HttpHeaders.authorizationHeader:
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1aWQiOjEsImlhdCI6MTU4NzkyNDM5NiwiZXhwIjoxNTg3OTI1NTk2fQ.EsVLTBm4lkUQcVPp2AuC0zL0_H7E-hiSoZDyZ7rDmXw"
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var p = Person.fromJson(json.decode(response.body));
    return p;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
