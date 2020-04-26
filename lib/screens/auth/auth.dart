import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/list_model.dart';
import 'package:consumo_web/screens/widgets/signin.dart';
import 'package:consumo_web/screens/widgets/signup.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  ListModel model = ListModel();
  bool loginScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text(
          loginScreen ? "Iniciar Sesión" : "Crear Cuenta",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        backgroundColor: AppColors.ocean_green,
      ),
      body: navigation(),
    );
  }

  Widget navigation() {
    return loginScreen
        ? SignIn(
            switchWidget: () {
              setState(() {
                loginScreen = !loginScreen;
              });
            },
            scaffoldKey: widget._scaffoldKey,
          )
        : SignUp(
            switchWidget: () {
              setState(() {
                loginScreen = !loginScreen;
              });
            },
          );
  }
}
