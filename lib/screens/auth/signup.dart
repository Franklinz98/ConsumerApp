import 'package:consumo_web/constants/colors.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final controllerName = TextEditingController();
  final controllerUsername = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Crear Cuenta",
          style: TextStyle(
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.ocean_green,
      ),
      body: Center(
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
                      controller: this.controllerName,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor ingrese su nombre';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        hintText: 'John Doe',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: this.controllerUsername,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Por favor ingrese su nombre de usuario';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Nombre de Usuario',
                        hintText: 'john.doe',
                      ),
                    ),
                  ),
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
                            // TODO login stuff
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
                        onPressed: () {}),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );;
  }
}
