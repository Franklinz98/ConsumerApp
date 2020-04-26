import 'package:consumo_web/models/person_model.dart';
import 'package:consumo_web/screens/widgets/profile_data.dart';
import 'package:flutter/material.dart';

class PersonDetails extends StatelessWidget {
  final Person person;

  PersonDetails({Key key, @required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          PersonData(person: this.person,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Cursos",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Container()
          ),
        ],
      ),
    );
  }
}
