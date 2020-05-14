import 'package:consumo_web/backend/auth.dart' as backend;
import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  final AuthProvider authProvider;
  final switchWidget;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SignIn(
      {Key key,
      @required this.authProvider,
      @required this.switchWidget,
      @required this.scaffoldKey})
      : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _remember=false;
  Widget buttonChild = Text(
    "ACEPTAR",
    style: TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.white,
    ),
  );

  @override
  void initState() {
    super.initState();
    // load data on startup
    _readPreferences();
  }
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
                    padding: EdgeInsets.only(top: 20),
                    child: CheckboxListTile(
                      activeColor: AppColors.ocean_green,
                        title: Text("Recordarme"),
                        value: _remember,
                        onChanged: (bool value) {
                          setState((){_remember=value;});
                        })),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MaterialButton(
                    color: AppColors.ocean_green,
                    height: 46.0,
                    shape: StadiumBorder(),
                    child: buttonChild,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        // login request
                        _futureBuilder();
                      }
                    },
                  ),
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
                      onPressed: widget.switchWidget),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Get Future Builder
  _futureBuilder() {
    setState(() {
      // Change Text for FutureBuilder
      buttonChild = FutureBuilder<User>(
        // Future: HTTP Request
        future: backend.login(
          controllerEmail.text,
          controllerPassword.text,
        ),
        builder: (context, snapshot) {
          // Succesful request: bind data
          if (snapshot.hasData) {
            User user = snapshot.data;
            _writePreferences(user);
            // Add callback for the end of build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.authProvider
                  .connect(user.name, user.email, user.username, user.token);
              Navigator.pop(context);
            });
            return Text(
              "ACEPTAR",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            );
          } else if (snapshot.hasError) {
            // Add callback for the end of build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text(snapshot.error.toString()),
                ),
              );
            });
            return Text(
              "ACEPTAR",
              style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.white,
              ),
            );
          }
          // By default, show a loading spinner.
          return SizedBox(
            height: 24.0,
            width: 24.0,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        },
      );
    });
  }

// Write user data after login
  _writePreferences(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', user.token);
    prefs.setString('name', user.name);
    prefs.setString('username', user.username);
    prefs.setString('email', user.email);
    
    if(_remember){
      prefs.setBool('remember', true);
      prefs.setString('r_email', user.email);
      prefs.setString('r_password', controllerPassword.text);      
    }else{
      prefs.setBool('remember', false);
      prefs.remove('r_password');
      prefs.remove('r_email');
    }
    controllerEmail.clear();
    controllerPassword.clear();
  }
  _readPreferences() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('remember')!=null && prefs.getBool('remember')){
      controllerEmail.text=prefs.getString('r_email');
      controllerPassword.text=prefs.getString('r_password');
      setState((){_remember=true;});
    }else{
      controllerEmail.clear();
      controllerPassword.clear();
    }
  }
}
