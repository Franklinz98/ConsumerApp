import 'package:consumo_web/backend/auth.dart' as backend;
import 'package:consumo_web/backend/courses.dart';
import 'package:consumo_web/backend/professors.dart';
import 'package:consumo_web/backend/students.dart';
import 'package:consumo_web/constants/colors.dart';
import 'package:consumo_web/models/user_model.dart';
import 'package:consumo_web/providers/auth_provider.dart';
import 'package:consumo_web/providers/list_provider.dart';
import 'package:consumo_web/screens/widgets/container/landing_page.dart';
import 'package:consumo_web/screens/widgets/content_list.dart';
import 'package:consumo_web/screens/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainContainer extends StatefulWidget {
  final AuthProvider authState;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  MainContainer({Key key, @required this.authState}) : super(key: key);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  FutureBuilder futureBuilder;
  Future<List> futureList;

  @override
  void initState() {
    super.initState();
    // load data on startup
    _readPreferences();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return !widget.authState.isLogged
        ? LandingPage(authState: widget.authState)
        : Consumer<ListProvider>(builder: (context, lists, child) {
            User user = widget.authState.user;
            if (futureList == null) {
              lists.view=0;
              futureList = fetchCourses(user.username, user.token);
            }
            _futureBuilder(lists);
            return Scaffold(
              key: widget._scaffoldKey,
              backgroundColor: AppColors.alabaster,
              appBar: AppBar(
                title: Text(
                  lists.title,
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: AppColors.tundora,
                  ),
                ),
                backgroundColor: Colors.white,
              ),
              drawer: CustomDrawer(
                scaffoldKey: widget._scaffoldKey,
                name: user.name,
                email: user.email,
                coursesOnTap: () {
                  setState(() {
                    lists.view = 0;
                    futureList = fetchCourses(user.username, user.token);
                  });
                },
                professorsOnTap: () {
                  setState(() {
                    lists.view = 1;
                    futureList = fetchProfessors(user.username, user.token);
                  });
                },
                studentsOnTap: () {
                  setState(() {
                    lists.view = 2;
                    futureList = fetchStudents(user.username, user.token);
                  });
                },
                onReset: () {
                  widget._scaffoldKey.currentState.openEndDrawer();
                  widget._scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Reiniciando BD...',
                      ),
                    ),
                  );
                  backend.resetDB(user.username, user.token).then(
                    (resetted) {
                      if (resetted) {
                        setState(() {
                          switch (lists.view) {
                            case 1:
                              futureList =
                                  fetchProfessors(user.username, user.token);
                              break;
                            case 2:
                              futureList =
                                  fetchStudents(user.username, user.token);
                              break;
                            default:
                              futureList =
                                  fetchCourses(user.username, user.token);
                              break;
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            widget._scaffoldKey.currentState
                                .hideCurrentSnackBar();
                            widget._scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Se reinició la BD',
                                ),
                              ),
                            );
                          });
                        });
                      } else {
                        widget._scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                              'DB wasn\'t resetted',
                            ),
                          ),
                        );
                      }
                    },
                  ).catchError(
                    (error) {
                      widget._scaffoldKey.currentState.openEndDrawer();
                      widget._scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(
                            error.toString(),
                          ),
                        ),
                      );
                    },
                  );
                },
                onLogOff: _unauthorizedProtocol,
              ),
              body: futureBuilder,
              floatingActionButton: Visibility(
                visible: lists.isVisible,
                child: FloatingActionButton(
                  backgroundColor: AppColors.ocean_green,
                  onPressed: () {
                    if (lists.view == 0) {
                      postCourse(user.username, user.token).then(
                        (course) {
                          lists.addCourse(course);
                        },
                      ).catchError(
                        (error) {
                          if (error.toString() == 'Unauthorized') {
                            _unauthorizedProtocol();
                          }
                        },
                      );
                    } else if (lists.view == 2) {
                      _addStudentDialog(user, lists);
                    }
                  },
                  tooltip: 'Add',
                  child: Icon(Icons.add),
                ),
              ),
            );
          });
  }

  // Read user data
  _readPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "none";
    // Check token
    backend.checkToken(token)
        // if it's valid, load data
        .then((isValid) {
      if (isValid) {
        print("k");
        String name = prefs.getString('name');
        String username = prefs.getString('username');
        String email = prefs.getString('email');
        widget.authState.connect(name, email, username, token);
        futureList = fetchCourses(username, token);
      } else {
        print("bruh");
        WidgetsBinding.instance.addPostFrameCallback(
          (_) {
            widget.authState.disconnect();
          },
        );
      }
    })
        // if not, set state to disconnected
        .catchError((error) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          widget.authState.disconnect();
        },
      );
    });
  }

// Remove user data after logoff
  _removePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');
    prefs.remove('username');
    prefs.remove('email');
  }

  _futureBuilder(ListProvider model) {
    futureBuilder = FutureBuilder<List>(
      // Future: HTTP Request
      future: futureList,
      builder: (context, snapshot) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget._scaffoldKey.currentState.openEndDrawer();
        });
        // Succesful request: bind data
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            model.changeList(snapshot.data);
            return ContentList(
              scaffoldKey: widget._scaffoldKey,
              model: model,
              user: widget.authState.user,
              unauthorizedProtocol: _unauthorizedProtocol,
            );
          } else if (snapshot.hasError) {
            if (snapshot.error.toString() == 'Unauthorized') {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  _unauthorizedProtocol();
                },
              );
            }
          }
        }
        // By default, show a loading spinner.
        return Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.ocean_green),
          ),
        );
      },
    );
  }

  _addStudentDialog(User user, ListProvider lists) {
    final _formKey = GlobalKey<FormState>();
    final controllerId = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            "Agregar estudiante",
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w500,
              color: AppColors.tundora,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: controllerId,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingrese el id del curso';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'ID del curso',
                          hintText: '1234',
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
                          Navigator.of(context).pop();
                          postStudent(user.username,
                                  int.parse(controllerId.text), user.token)
                              .then(
                            (student) {
                              lists.addStudent(student);
                            },
                          ).catchError(
                            (error) {
                              _unauthorizedProtocol();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _unauthorizedProtocol() {
    Navigator.of(context).maybePop();
    futureList=null;
    widget.authState.disconnect();
    _removePreferences();
  }
}
