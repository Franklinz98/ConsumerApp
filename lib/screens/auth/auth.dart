import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/providers/auth_provider.dart';
import 'package:consumo_web/screens/widgets/auth/signin.dart';
import 'package:consumo_web/screens/widgets/auth/signup.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  final AuthProvider authProvider;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Auth({Key key, @required this.authProvider}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  int screen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget._scaffoldKey,
      appBar: AppBar(
        title: Text(
          screen == 0 ? "Iniciar Sesión" : "Crear Cuenta",
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
    return screen == 0
        ? SignIn(
            authProvider: widget.authProvider,
            switchWidget: () {
              setState(() {
                screen = 1;
              });
            },
            scaffoldKey: widget._scaffoldKey,
          )
        : SignUp(
            authProvider: widget.authProvider,
            switchWidget: () {
              setState(() {
                screen = 0;
              });
            },
            scaffoldKey: widget._scaffoldKey,
          );
  }
}
