import 'package:consumo_web/backend/auth.dart' as backend;
import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/list_model.dart';
import 'package:consumo_web/screens/content/main_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  final switchWidget;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignIn({Key key, @required this.switchWidget, @required this.scaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: this.controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor ingrese su correo electrónico';
                      } else if (!value.contains('@')) {
                        return 'Por favor ingrese un correo electrónico válido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      hintText: 'user@example.com',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    controller: this.controllerPassword,
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por favor ingrese su contraseña';
                      } else if (value.length < 6) {
                        return 'La contraseña de tener al menos 6 caracteres';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MaterialButton(
                      color: AppColors.ocean_green,
                      height: 46.0,
                      shape: StadiumBorder(),
                      child: Text(
                        "ACEPTAR",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          backend
                              .login(
                            controllerEmail.text,
                            controllerPassword.text,
                          )
                              .then((user) {
                            ListModel model = ListModel();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<ListModel>(
                                  create: (context) => model,
                                  child: MainContainer(
                                    model: model,
                                    user: user,
                                  ),
                                ),
                              ),
                            );
                          }).catchError((error) {
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(error.toString()),
                              ),
                            );
                          });
                        }
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MaterialButton(
                      color: Colors.white,
                      height: 46.0,
                      shape: StadiumBorder(),
                      child: Text(
                        "CREAR USUARIO",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.ocean_green,
                        ),
                      ),
                      onPressed: this.switchWidget),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
