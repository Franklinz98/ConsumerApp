import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/providers/auth_provider.dart';
import 'package:consumo_web/screens/auth/auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final AuthProvider authState;

  const LandingPage({Key key, @required this.authState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Bienvenido",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        backgroundColor: AppColors.ocean_green,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: MaterialButton(
            color: AppColors.ocean_green,
            height: 46.0,
            shape: StadiumBorder(),
            child: Text(
              "Iniciar Sesión",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Auth(
                    authProvider: this.authState,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
