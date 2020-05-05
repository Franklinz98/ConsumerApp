import 'package:consumo_web/models/person_model.dart';
import 'package:flutter/material.dart';

class ProfileData extends StatelessWidget {
  final Person person;

  const ProfileData({Key key, @required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 178.0,
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 0.00),
            color: Colors.black.withOpacity(0.16),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(4.00),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  height: 110.00,
                  width: 110.00,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://api.adorable.io/avatars/285/' +
                              person.email),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        person.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xff444444),
                        ),
                      ),
                      Text(
                        person.username,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 12,
                          color: Color(0xffb5b8b7),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                person.birthday.substring(0, 10),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  color: Color(0xff444444),
                                ),
                              ),
                              Text(
                                person.email,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  color: Color(0xff444444),
                                ),
                              ),
                              Text(
                                person.phone,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 12,
                                  color: Color(0xff444444),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Text(
            person.city + ', ' + person.country,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Color(0xffb5b8b7),
            ),
          )
        ],
      ),
    );
  }
}
